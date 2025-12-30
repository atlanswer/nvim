return {
    "pmizio/typescript-tools.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
    },
    -- cond = not vim.g.vscode,
    cond = false,
    opts = {
        capabilities = require("blink-cmp").get_lsp_capabilities(),
    },
}
