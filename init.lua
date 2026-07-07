-- Configs
require "config.options"

-- Experimental
-- vim.opt.cmdheight = 0
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--     desc = "Restore cmdline when entered",
--     group = vim.api.nvim_create_augroup(
--         "nvim-restore-cmdline",
--         { clear = true }
--     ),
--     callback = function()
--         vim.opt.cmdheight = 1
--     end,
-- })
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--     desc = "Hide cmdline when left",
--     group = vim.api.nvim_create_augroup("nvim-hide-cmdline", { clear = true }),
--     callback = function()
--         vim.opt.cmdheight = 0
--     end,
-- })

-- Suppress vscode output
if vim.g.vscode then
    vim.opt.cmdheight = 3
end

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

-- Diagnostic configs
vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { source = true },
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },
    virtual_text = true,
    virtual_lines = false,
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float {
                bufnr = bufnr,
                scope = "cursor",
                focus = false,
            }
        end,
    },
}

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
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.open = function(path, opt)
    if vim.fn.executable "explorer.exe" == 1 and opt == nil then
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

-- Lazy.nvim
require "config.lazy"

-- Default color scheme
if not vim.g.vscode then
    vim.cmd.colorscheme "rose-pine"
end

-- Key mappings
require "config.keymaps"

vim.filetype.add {
    filename = {
        ["config.ghostty"] = "conf",
    },
}
