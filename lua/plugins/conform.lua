return {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode,
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        notify_on_error = true,
        notify_no_formatters = true,
        formatters_by_ft = {
            lua = { "stylua" },
            json = { "prettier" },
            jsonc = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            astro = { "prettier" },
            markdown = { "prettier" },
            yaml = { "prettier" },
            toml = { "pyproject-fmt" },
        },
        formatters = {
            -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/prettier.lua
            prettier = {
                command = "bunx",
                args = { "--bun", "prettier", "--stdin-filepath", "$FILENAME" },
            },
            -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/pyproject-fmt.lua
            ["pyproject-fmt"] = {
                command = "uvx",
                args = { "pyproject-fmt", "-" },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format {
                    async = true,
                    lsp_format = "fallback",
                }
            end,
            desc = "[F]ormat buffer",
        },
    },
}
