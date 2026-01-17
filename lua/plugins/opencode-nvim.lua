return {
    "NickvanDyke/opencode.nvim",
    cond = not vim.g.vscode,
    dependencies = {
        -- Recommended for `ask()` and `select()`.
        -- Required for `snacks` provider.
        ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
        { "folke/snacks.nvim" },
    },
    init = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            select = { snacks = { layout = { cycle = true } } },
        }
    end,
    keys = {
        {
            "<C-.>",
            function()
                require("opencode").toggle()
            end,
            mode = { "n", "t" },
            desc = "OpenCode: toggle",
        },
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ", { submit = true })
            end,
            mode = { "n", "x" },
            desc = "OpenCode: ask this",
        },
        {
            "<leader>ox",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            desc = "OpenCode: execute actions",
        },
        {
            "go",
            function()
                return require("opencode").operator "@this "
            end,
            mode = { "n", "x" },
            desc = "OpenCode: add range",
            expr = true,
        },
        {
            "goo",
            function()
                return require("opencode").operator "@this " .. "_"
            end,
            desc = "OpenCode: add line",
            expr = true,
        },
        {
            "<C-A-u>",
            function()
                require("opencode").command "session.half.page.up"
            end,
            desc = "OpenCode: scroll up",
        },
        {
            "<C-A-d>",
            function()
                require("opencode").command "session.half.page.down"
            end,
            desc = "OpenCode: scroll down",
        },
    },
}
