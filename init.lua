-- Map leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.confirm = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "81"

vim.opt.updatetime = 300
vim.opt.timeoutlen = 1000

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"
vim.opt.incsearch = true

vim.opt.fileformats = "unix,dos"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cindent = true
vim.opt.breakindent = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.opt.termguicolors = true
vim.opt.guicursor = "a:Cursor/lCursor,\z
                     n-v-c:block,\z
                     i-ci-ve:ver25-blinkwait0-blinkoff500-blinkon500,\z
                     r-cr-o:hor20,\z
                     sm:blinkwait0-blinkoff500-blinkon500,\z
                     t:TermCursor"

-- Experimental
vim.opt.cmdheight = 0
vim.api.nvim_create_autocmd("CmdlineEnter", {
    desc = "Restore cmdline when entered",
    group = vim.api.nvim_create_augroup(
        "nvim-restore-cmdline",
        { clear = true }
    ),
    callback = function()
        vim.opt.cmdheight = 1
    end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
    desc = "Hide cmdline when left",
    group = vim.api.nvim_create_augroup("nvim-hide-cmdline", { clear = true }),
    callback = function()
        vim.opt.cmdheight = 0
    end,
})

-- Fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldenable = false

-- Per directory overrides
vim.opt.exrc = true

-- Add empty blank line
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     desc = "Add blank line at the end of file",
--     group = vim.api.nvim_create_augroup(
--         "nvim-blank-line-eof",
--         { clear = true }
--     ),
--     callback = function()
--         local last_line = vim.api.nvim_buf_get_lines(0, -2, -1, true)[1]
--         if vim.fn.empty(last_line) == 0 then
--             vim.api.nvim_buf_set_lines(0, -1, -1, true, { "" })
--         end
--     end,
-- })

-- Highlight when copying
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup(
        "nvim-highlight-yank",
        { clear = true }
    ),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Set terminal to pwsh on Windows
if vim.fn.index(vim.fn.keys(vim.fn.environ()), "shell", 0, true) == -1 then
    vim.opt.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
    vim.opt.shellcmdflag =
        "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
    vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

-- Using explorer.exe to open URL
local original_open = vim.ui.open
---@param path string
---@param opt? string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(path, opt)
    if vim.fn.executable "explorer.exe" and opt == nil then
        return original_open(path, { cmd = { "explorer.exe" } })
    end
    return original_open(path, opt)
end

-- Disable line number in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Disable line number in terminal mode",
    group = vim.api.nvim_create_augroup("nvim-term-custom", { clear = true }),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})

-- Load Lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
end

----@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup "plugins"

if not vim.g.vscode then
    vim.cmd.colorscheme "rose-pine"
end

-- Key mappings
require "keymaps"
