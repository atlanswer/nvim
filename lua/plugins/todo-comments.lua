return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = not vim.g.vscode,
    opts = {
        keywords = {
            TEMP = { icon = " ", color = "hint" },
        },
    },
    keys = {
        {
            "<leader>st",
            function()
                ---@diagnostic disable-next-line: undefined-global
                Snacks.picker.todo_comments()
            end,
            desc = "Search: Todo",
        },
        {
            "<leader>sT",
            function()
                ---@diagnostic disable-next-line: undefined-global
                Snacks.picker.todo_comments {
                    keywords = { "TODO", "FIX", "FIXME" },
                }
            end,
            desc = "Search: Todo/Fix/Fixme",
        },
    },
}
