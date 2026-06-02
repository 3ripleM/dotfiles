-- Network call interceptor for banking/secure environments.
-- Wraps all Neovim/Lua process-spawning APIs to prompt before any network call.
-- Child processes of already-running jobs cannot be intercepted here;
-- use OS-level firewall rules (see docs/network-hardening.md) for full coverage.

local M = {}

local NETWORK_PATTERNS = {
  "curl%s",
  "curl$",
  "wget%s",
  "wget$",
  "git%s+clone",
  "git%s+fetch",
  "git%s+pull",
  "git%s+push",
  "https?://",
  "ssh://",
  "git@",
  "npm%s+install",
  "npm%s+ci",
  "yarn%s+install",
  "pip%s+install",
  "pip3%s+install",
  "cargo%s+fetch",
  "cargo%s+install",
  "go%s+get",
  "go%s+install",
}

-- Commands that are always allowed through regardless of network patterns
local ALLOWLIST = {
  "lazygit",
}

local function is_allowlisted(str)
  for _, allowed in ipairs(ALLOWLIST) do
    if str:lower():match(allowed) then
      return true
    end
  end
  return false
end

local function looks_like_network(cmd)
  local str = type(cmd) == "table" and table.concat(cmd, " ") or tostring(cmd)
  if is_allowlisted(str) then return false, str end
  for _, pat in ipairs(NETWORK_PATTERNS) do
    if str:lower():match(pat) then
      return true, str
    end
  end
  return false, str
end

local function prompt(cmdstr, on_allow, on_deny)
  vim.schedule(function()
    vim.ui.select({ "Allow", "Deny" }, {
      prompt = "⚠️  Network call detected:\n" .. cmdstr:sub(1, 120) .. "\n",
    }, function(choice)
      if choice == "Allow" then
        on_allow()
      else
        vim.notify("[security] Blocked network call: " .. cmdstr:sub(1, 80), vim.log.levels.WARN)
        if on_deny then on_deny() end
      end
    end)
  end)
end

function M.setup()
  -- 1. vim.fn.jobstart — async jobs (most plugins use this)
  local orig_jobstart = vim.fn.jobstart
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.jobstart = function(cmd, opts)
    local is_net, cmdstr = looks_like_network(cmd)
    if is_net then
      prompt(cmdstr, function()
        orig_jobstart(cmd, opts)
      end, function()
        if opts and opts.on_exit then opts.on_exit(0, 1, "signal") end
      end)
      return -1
    end
    return orig_jobstart(cmd, opts)
  end

  -- 2. vim.fn.termopen — terminal buffers (toggleterm, lazygit integrations)
  local orig_termopen = vim.fn.termopen
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.termopen = function(cmd, opts)
    local is_net, cmdstr = looks_like_network(cmd)
    if is_net then
      prompt(cmdstr, function()
        orig_termopen(cmd, opts)
      end)
      return -1
    end
    return orig_termopen(cmd, opts)
  end

  -- 3. vim.fn.system — synchronous blocking shell calls
  local orig_fn_system = vim.fn.system
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.system = function(cmd, ...)
    local is_net, cmdstr = looks_like_network(cmd)
    if is_net then
      -- system() is synchronous so we can't async-prompt; block and warn
      vim.notify("[security] Blocked synchronous network call: " .. cmdstr:sub(1, 80), vim.log.levels.ERROR)
      return ""
    end
    return orig_fn_system(cmd, ...)
  end

  -- 4. vim.system — Neovim 0.10+ async (different from vim.fn.system)
  if vim.system then
    local orig_system = vim.system
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.system = function(cmd, opts, on_exit)
      local is_net, cmdstr = looks_like_network(cmd)
      if is_net then
        prompt(cmdstr, function()
          orig_system(cmd, opts, on_exit)
        end, function()
          if on_exit then
            on_exit({ code = 1, signal = 0, stdout = "", stderr = "blocked by security policy" })
          end
        end)
        return nil
      end
      return orig_system(cmd, opts, on_exit)
    end
  end

  -- 5. vim.uv.spawn / vim.loop.spawn — libuv direct process spawning
  local uv = vim.uv or vim.loop
  if uv and uv.spawn then
    local orig_spawn = uv.spawn
    uv.spawn = function(path, opts, on_exit)
      local args = opts and opts.args or {}
      local cmdstr = path .. " " .. table.concat(args, " ")
      local is_net, _ = looks_like_network(cmdstr)
      if is_net and not is_allowlisted(path) then
        prompt(cmdstr, function()
          orig_spawn(path, opts, on_exit)
        end, function()
          if on_exit then on_exit(1, 0) end
        end)
        return nil, "blocked"
      end
      return orig_spawn(path, opts, on_exit)
    end
  end

  -- 6. io.popen / os.execute — Lua stdlib (rarely used by plugins but possible)
  local orig_popen = io.popen
  io.popen = function(cmd, mode)
    local is_net, cmdstr = looks_like_network(cmd)
    if is_net then
      vim.notify("[security] Blocked io.popen network call: " .. cmdstr:sub(1, 80), vim.log.levels.ERROR)
      return nil
    end
    return orig_popen(cmd, mode)
  end

  local orig_execute = os.execute
  os.execute = function(cmd)
    if cmd then
      local is_net, cmdstr = looks_like_network(cmd)
      if is_net then
        vim.notify("[security] Blocked os.execute network call: " .. cmdstr:sub(1, 80), vim.log.levels.ERROR)
        return false, "blocked", 1
      end
    end
    return orig_execute(cmd)
  end
end

return M

