return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.nvim",
    },
    event = "VeryLazy",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        completions = { lsp = { enabled = true } },
    },
    cond = not vim.g.vscode,
}
