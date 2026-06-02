return {
  "kamykn/spelunker.vim",
  dependencies = {
    "kamykn/popup-menu.nvim",
  },
  event = { "BufReadPre", "BufNewFile" }, -- Load only when a buffer is read or a new file is created
  config = function()
    -- Enable spell checking for comments in code files
    vim.g.spelunker_check_comments = 1

    -- Enable spelling check for certain filetypes (like markdown and text)
    vim.g.spelunker_check_type = 2

    -- Delay before checking spelling (in ms)
    vim.g.spelunker_delay = 150

    -- Customize the highlight for misspelled words
    vim.cmd([[ highlight SpelunkerSpellBad cterm=underline ctermfg=red guifg=#FAA0A0 ]])
    vim.cmd([[ highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE ]])

    -- Ignore specific words
    vim.g.spelunker_white_list_for_comment = { "TODO", "FIXME" }
    vim.cmd([[hi Pmenu ctermfg=254 ctermbg=236 cterm=NONE guifg=#e1e1e1 guibg=#383838 gui=NONE]])
    vim.cmd([[hi PmenuSel ctermfg=203 ctermbg=239 cterm=NONE guifg=#FAA0A0 guibg=#FAA0A0 gui=NONE]])
  end,
}
