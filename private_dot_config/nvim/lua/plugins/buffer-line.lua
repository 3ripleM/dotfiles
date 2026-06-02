return {
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    -- I've manually changed the highlights in bufferline to match catppuccin
    -- replace to default if failed
    -- /Users/medi/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins
  },

  {
    "romgrk/barbar.nvim",
    enabled = false,
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
  },
}
