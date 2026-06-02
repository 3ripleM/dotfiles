return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Disable auto-install of parsers (no network calls)
      require("nvim-treesitter").setup({ auto_install = false })

      -- Pre-install parsers for common languages
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "query", "typescript", "javascript", "json",
      })

      -- Disable treesitter for large files (>100KB)
      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(ev)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if ok and stats and stats.size > max_filesize then
            vim.b[ev.buf].large_file = true
          end
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if vim.b[ev.buf].large_file then
            vim.treesitter.stop(ev.buf)
          end
        end,
      })
    end,
  },
  -- {
  --   "nvim-treesitter-context",
  --   opts = {
  --     max_lines = 2,
  --   },
  -- },
  {
    "nvim-treesitter-textobjects",
  },
}
