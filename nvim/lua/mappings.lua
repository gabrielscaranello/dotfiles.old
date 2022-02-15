local map = vim.api.nvim_set_keymap
local g = vim.g
local opts = { noremap = true, silent = true }

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

-- enable ctrl+s
map("", "<C-s>", "<cmd>:w<CR>", opts)

-- Delete without yank
map('n', '<leader>d', '"_d', opts)
map('n', 'x', '"_x', opts)

-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", opts)
map("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", opts)
map("n", "<leader>p", "<cmd>NvimTreeFindFile<CR>", opts)
