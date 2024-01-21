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

vim.opt.fileformats = "unix,dos"
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

-- keymap for leap
local function create_leap_mappings()
    for _, _1_ in ipairs({{{"n", "x", "o"}, "s", "<Plug>(leap-forward)", "Leap forward"}, {{"n", "o"}, "S", "<Plug>(leap-backward)", "Leap backward"}, {{"n", "x", "o"}, "gs", "<Plug>(leap-from-window)", "Leap from window"}}) do
	local _each_2_ = _1_
	local modes = _each_2_[1]
	local lhs = _each_2_[2]
	local rhs = _each_2_[3]
	local desc = _each_2_[4]
	for _0, mode in ipairs(modes) do
	    local rhs_2a = vim.fn.mapcheck(lhs, mode)
	    if (rhs_2a == "") then
		vim.keymap.set(mode, lhs, rhs, {silent = true, desc = desc})
	    else
		if (rhs_2a ~= rhs) then
		    local msg = ("leap.nvim: create_default_mappings() " .. "found conflicting mapping for " .. lhs .. ": " .. rhs_2a)
		    vim.notify(msg, vim.log.levels.WARN)
		else
		end
	    end
	end
    end
    return nil
end

create_leap_mappings()

if not vim.g.vscode then
    vim.cmd.colorscheme("onedark")
end
