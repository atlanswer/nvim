return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@module "flash"
    ---@type Flash.Config
    opts = {},
    keys = {
        {
            "ss",
            function()
                require("flash").jump()
            end,
            mode = { "n", "x", "o" },
            desc = "Flash",
        },
        {
            "<A-s>",
            function()
                require("flash").treesitter()
            end,
            mode = { "n", "x", "o" },
            desc = "Flash Treesitter",
        },
        {
            "r",
            function()
                require("flash").remote()
            end,
            mode = { "o" },
            desc = "Remote Flash",
        },
        {
            "R",
            function()
                require("flash").treesitter_search()
            end,
            mode = { "o", "x" },
            desc = "Treesitter Search",
        },
        {
            "<C-s>",
            function()
                require("flash").toggle()
            end,
            mode = { "c" },
            desc = "Toggle Flash Search",
        },
    },
    specs = {
        {
            "folke/snacks.nvim",
            opts = {
                picker = {
                    win = {
                        input = {
                            keys = {
                                ["s"] = { "flash" },
                                ["<A-s>"] = { "flash", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        flash = function(picker)
                            require("flash").jump {
                                pattern = "^",
                                label = { after = { 0, 0 } },
                                search = {
                                    mode = "search",
                                    exclude = {
                                        function(win)
                                            return vim.bo[vim.api.nvim_win_get_buf(
                                                win
                                            )].filetype ~= "snacks_picker_list"
                                        end,
                                    },
                                },
                                action = function(match)
                                    local idx =
                                        picker.list:row2idx(match.pos[1])
                                    picker.list:_move(idx, true, true)
                                end,
                            }
                        end,
                    },
                },
            },
        },
    },
}
