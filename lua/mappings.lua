vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = {
    noremap = true,
    silent = true,
}

local map = vim.api.nvim_set_keymap
map("n", "<leader>w", ":w<CR>", opt)
map("i", "jk", "<Esc>", opt)
map("n", "<leader>Q", ":q!<CR>", opt)
map("n", "<leader>sv", ":vsplit<CR>", opt)
map("n", "<leader>sh", ":split<CR>", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<leader>e", ":Neotree toggle<CR>", opt)
map("n", "<leader>cg", ":CMakeGenerate<CR>", opt)
map("n", "<leader>cb", "<cmd>CMakeBuild<CR>", opt)
map("n", "<leader>cr", "<cmd>CMakeRun<CR>", opt)
map("n", "<leader>cd", "<cmd>CMakeDebug<CR>", opt)
map("n", "<leader>cc", "<cmd>CMakeClean<CR>", opt)
map("n", "<leader>r", ":w<CR>:!g++ % -o %:r -std=c++20 -Wall && ./%:r<CR>", opt)



