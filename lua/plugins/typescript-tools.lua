return {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
    },
    opts = {
        capabilities = require("blink-cmp").get_lsp_capabilities(),
        settings = {
            expose_as_code_action = "all",
        },
    },
    cond = not vim.g.vscode,
}
