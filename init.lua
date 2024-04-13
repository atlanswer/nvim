vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 500
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

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

vim.opt.scrolloff = 10

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/kolke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {defaults = {lazy = true}})

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

-- Move selection
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv")

-- Page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Preserve copy
vim.keymap.set("x", "<leader>p", "\"_dP")

-- System clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete into void
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Search
vim.opt.hlsearch = true
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
})

if not vim.g.vscode then
    vim.opt.termguicolors = true
    vim.opt.guicursor = "n-v-c:block-Cursor,\z
                         i-ci-ve:ver50-iCursor-\z
                         blinkwait700-blinkoff300-blinkon300,\z
                         r-cr:hor20,o:hor50,\z
                         sm:blinkwait500-blinkoff300-blinkon200"
    vim.cmd.colorscheme("onedark")
end
