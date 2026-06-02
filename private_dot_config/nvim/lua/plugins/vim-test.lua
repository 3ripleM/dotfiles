return {
  {
    "vim-test/vim-test",
    dependencies = { "akinsho/toggleterm.nvim" },
    keys = {
      { "<leader>t", "<cmd>TestNearest<cr>", desc = "Test Nearest" },
      { "<leader>T", "<cmd>TestFile<cr>", desc = "Test File" },
      { "<leader>a", "<cmd>TestSuite<cr>", desc = "Test Suite" },
      { "<leader>l", "<cmd>TestLast<cr>", desc = "Test Last" },
    },
    config = function()
      vim.cmd("let test#strategy = 'toggleterm'")
    end,
  },
}
