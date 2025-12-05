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

        -- https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/cspell.lua
        lint.linters.cspell.cmd = "bunx"
        lint.linters.cspell.args = {
            "--bun",
            "cspell",
            "lint",
            "--no-color",
            "--no-progress",
            "--no-summary",
            function()
                return "stdin://" .. vim.api.nvim_buf_get_name(0)
            end,
        }
    end,
}
