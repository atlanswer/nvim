return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    cond = not vim.g.vscode,
    opts = {},
    keys = {
        {
            "<leader>st",
            function()
                Snacks.picker.todo_comments()
            end,
            desc = "Search: Todo",
        },
        {
            "<leader>sT",
            function()
                Snacks.picker.todo_comments {
                    keywords = { "TODO", "FIX", "FIXME" },
                }
            end,
            desc = "Search: Todo/Fix/Fixme",
        },
    },
}
