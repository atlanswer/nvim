return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    opts = {
        delay = 1000,
        icons = {
            mappings = vim.g.have_nerd_font,
        },
        spec = {
            { "<leader>f", group = "[F]ormat" },
            { "<leader>s", group = "[S]earch" },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>g", group = "[G]it" },
        },
    },
}
