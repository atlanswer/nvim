return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    opts = {
        move = {
            -- whether to set jumps in the jumplist
            set_jumps = true,
        },
    },
    keys = {
        {
            "<leader>sp",
            function()
                require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
            end,
            mode = "n",
            desc = "Swap with next parameter",
        },
        {
            "<leader>sP",
            function()
                require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
            end,
            mode = "n",
            desc = "Swap with previous parameter",
        },
    },
}
