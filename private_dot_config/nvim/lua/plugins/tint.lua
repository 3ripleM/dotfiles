return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      tint = -30,
      saturation = 0.5,
      tint_background_colors = true,
    },
    config = function(_, opts)
      local tint = require("tint")
      tint.setup(opts)

      local function is_diffview_active()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
          if ok then
            local ft = vim.bo[buf].filetype
            if ft:match("^Diffview") then
              return true
            end
          end
        end
        return false
      end

      local function untint_all()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          tint.untint(win)
        end
      end

      vim.api.nvim_create_autocmd("WinEnter", {
        callback = function()
          if is_diffview_active() then
            untint_all()
          end
        end,
      })

      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          if is_diffview_active() then return end
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            tint.tint(win)
          end
        end,
      })

      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          untint_all()
        end,
      })
    end,
  },
}
