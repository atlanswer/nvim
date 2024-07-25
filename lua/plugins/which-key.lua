return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
    },
    cond = not vim.g.vscode,
}
