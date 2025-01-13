-- Map leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Malicious settings
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 800

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.incsearch = true

vim.opt.fileformats = "unix,dos"

vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cindent = true

vim.opt.colorcolumn = "81"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.opt.termguicolors = true
vim.opt.guicursor = "n-v-c:block-Cursor,\z
                     i-ci-ve:ver50-iCursor-\z
                     blinkwait700-blinkoff300-blinkon300,\z
                     r-cr:hor20,o:hor50,\z
                     sm:blinkwait500-blinkoff300-blinkon200"

-- Set terminal to pwsh on Windows
if vim.fn.index(vim.fn.keys(vim.fn.environ()), "shell", 0, 1) == -1 then
    vim.opt.shell = "pwsh"
end

-- Disable line number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("nvim-term-custom", { clear = true }),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})

-- Load Lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    }
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup "plugins"

vim.cmd.colorscheme "onedark"

-- Key mappings
require "keymaps"
