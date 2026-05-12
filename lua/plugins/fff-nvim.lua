return {
    "dmtrKovalenko/fff.nvim",
    build = function()
        -- downloads a prebuilt binary
        require("fff.download").download_binary()
    end,
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
        debug = {
            enabled = false,
            show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
        },
    },
    -- This plugin initializes itself lazily
    lazy = false,
    keys = {
        {
            "<leader>sf",
            function()
                require("fff").find_files()
            end,
            mode = { "n" },
            desc = "FFFind files",
        },
        {
            "<leader>sn",
            function()
                require("fff").find_files_in_dir(vim.fn.stdpath "config")
            end,
            mode = { "n" },
            desc = "FFFind files in Neovim configs",
        },
        {
            "<leader>sg",
            function()
                require("fff").live_grep()
            end,
            mode = { "n" },
            desc = "LiFFFe grep",
        },
        {
            "<leader>sz",
            function()
                require("fff").live_grep {
                    grep = { modes = { "fuzzy", "plain" } },
                }
            end,
            mode = { "n" },
            desc = "Live FFFuzy grep",
        },
        {
            "<leader>s*",
            function()
                require("fff").live_grep {
                    { query = { vim.fn.expand "<cword>" } },
                }
            end,
            mode = { "n" },
            desc = "Search current word",
        },
    },
}
