return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    cond = not vim.g.vscode,
    config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
            kotlin = { "ktlint" },
        }

        local lint_augroup =
            vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWritePost", "InsertLeave" },
            {
                group = lint_augroup,
                callback = function()
                    if vim.opt_local.modifiable:get() then
                        lint.try_lint()
                    end
                end,
            }
        )
        vim.keymap.set("n", "<leader>cs", function()
            lint.try_lint "cspell"
        end, {
            desc = "[C]heck [S]pelling",
        })

        lint.linters.cspell.cmd = "bunx --bun cspell"
    end,
}
