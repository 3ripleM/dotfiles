return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    tag = "v1.10.0",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
    },
    config = function()
      -- catppuccin v1.x moved catppuccin.special.bufferline to
      -- catppuccin.groups.integrations.bufferline, but LazyVim still
      -- requires the old path. Shim it so bufferline config doesn't crash.
      package.preload["catppuccin.special.bufferline"] = function()
        local M = {}
        function M.get_theme()
          local ok, integration = pcall(require, "catppuccin.groups.integrations.bufferline")
          if not ok then return {} end
          local result = integration.get()
          return type(result) == "function" and result() or result
        end
        return M
      end

      require("catppuccin").setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = false,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          notify = true,
          nvimtree = true,
          neotree = true,
          noice = true,
          symbols_outline = true,
          bufferline = false,
          telescope = {
            enabled = true,
            --style = "nvchad",
          },
          treesitter = true,
          treesitter_context = true,
          barbecue = {
            dim_dirname = true, -- directory name is dimmed by default
            bold_basename = true,
            dim_context = false,
            alt_background = false,
          },
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
      })

      vim.cmd.colorscheme("catppuccin-mocha")

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
}
