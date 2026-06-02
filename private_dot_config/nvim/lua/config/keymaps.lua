-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.del("n", ";")

-- Remove mapping for alt j/k line swapping
vim.keymap.del({ "n", "v", "i" }, "<A-j>")
vim.keymap.del({ "n", "v", "i" }, "<A-k>")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move to window using the <ctrl> hjkl keys

-- Telescope
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "find files" })

-- Buffer Mappings
vim.keymap.set("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- NvimTree
vim.keymap.set("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle NvimTree" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })

vim.keymap.set("n", "<leader>w", "<cmd>bd<cr>", { desc = "Close buffer" })

vim.keymap.set("n", "<C-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
vim.keymap.set("n", "]g", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })

-- Harpoon
vim.keymap.set(
  "n",
  "<C-_>", -- maps to ctrl + / tooooooo
  "<cmd>lua require('harpoon.mark').add_file()<cr>",
  { desc = "Add file to harpoon", remap = true }
)

vim.keymap.set(
  "n",
  "<C-i>", -- maps to tab toooooooo
  "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
  { desc = "Toggle Harpoon", remap = true }
)

-- bufferline
vim.keymap.set("n", "gb", "<cmd>:BufferLinePick<cr>")

-- treesitter
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
