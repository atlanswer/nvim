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
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>f", group = "[F]ormat" },
            { "<leader>r", group = "[R]ename" },
            { "<leader>s", group = "[S]earch" },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>g", group = "[G]it" },
        },
    },
}
