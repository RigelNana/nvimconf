vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("common")
require("mappings")
require("lazy-init")

vim.cmd("colorscheme " .. "catppuccin")
