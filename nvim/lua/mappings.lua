local map = vim.api.nvim_set_keymap
local g = vim.g
local opts = {noremap = true, silent = true}

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- enable ctrl+s
map("", "<C-s>", "<cmd>:w<CR>", opts)
map("i", "<C-s>", "<cmd>:w<CR>", opts)

-- Delete without yank
map("n", "<leader>d", '"_d', opts)
map("n", "x", '"_x', opts)

-- Navigate buffers
map("n", "<Tab>", "<cmd>bnext<CR>", opts)
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)

-- Move text up and down
map("n", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", opts)

-- NeoTree
map("n", "<leader>o", "<cmd>NeoTreeFocus<CR>", opts)
map("n", "<leader>p", "<cmd>NeoTreeFocusToggle<CR>", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", "<cmd>m .+1<CR>==", opts)
map("v", "<A-k>", "<cmd>m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- disable Ex mode:
map("n", "Q", "<Nop>", opts)

-- ForceWrite
map("n", "<C-w>", "<cmd>w!<CR>", opts)

-- ForceQuit
map("n", "<C-q>", "<cmd>q!<CR>", opts)