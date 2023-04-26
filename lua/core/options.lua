-- Leader/local leader - lazy.nvim needs these set first
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
-- long lived undodir
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- vim.cmd.colorscheme "catppuccin"  -- mocha

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- ms of pausing to write to swap file
vim.opt.updatetime = 750

vim.opt.colorcolumn = "80"
