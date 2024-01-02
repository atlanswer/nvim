local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/kolke/lazy.nvim.git",
	"--branch=stable", -- latest stable release
	lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.fileformats = "unix"
vim.opt.swapfile = false
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "81"
vim.opt.scrolloff = 5

vim.g.mapleader = " "

require("lazy").setup("plugins", {defaults = {lazy = true}})

require("nvim-surround").setup()
require("leap").create_default_mappings()

if not vim.g.vscode then
    vim.cmd.colorscheme("onedark")
end
