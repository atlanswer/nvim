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
            { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
            { "<leader>g", group = "[G]it" },
            { "<leader>t", group = "[T]oggle" },
            { "gr", group = "LSP Actions", mode = { "n" } },
        },
    },
}
