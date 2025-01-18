return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format { async = true }
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        notify_on_error = true,
        notify_no_formatters = true,
        formatters_by_ft = {
            lua = { "stylua" },
            json = { "prettier" },
            jsonc = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            markdown = { "prettier" },
            tsx = { "prettier" },
            astro = { "prettier" },
        },
        default_format_opts = { lsp_format = "fallback" },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    cond = not vim.g.vscode,
}
