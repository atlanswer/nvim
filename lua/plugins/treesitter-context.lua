return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = { enable = true },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cond = not vim.g.vscode,
}
