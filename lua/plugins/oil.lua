return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.nvim" },
    cond = not vim.g.vscode,
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
        columns = {
            { "mtime", format = "%y/%m/%d %H:%M" },
            "size",
            "icon",
        },
        view_options = {
            show_hidden = true,
        },
        win_options = {
            winbar = "%#@attribute.builtin#%{substitute("
                .. "v:lua.require('oil').get_current_dir(), "
                .. "'^' . escape($HOME, '\\'), '~', '')}",
        },
        keymaps = {
            ["<C-h>"] = false,
            ["<A-h>"] = {
                "actions.select",
                opts = { horizontal = true },
                desc = "Open in horizontal split",
            },
            ["<A-j>"] = {
                "actions.select",
                opts = { vertical = true },
                desc = "Open in vertical split",
            },
            ["<C-l>"] = false,
            ["<A-p>"] = { "actions.preview" },
            ["<A-l>"] = { "actions.refresh" },
            ["<leader>sf"] = {
                function()
                    require("fff").find_files_in_dir(
                        ---@diagnostic disable-next-line
                        require("oil").get_current_dir()
                    )
                    -- ---@diagnostic disable-next-line
                    -- Snacks.picker.files {
                    --     cwd = require("oil").get_current_dir(),
                    -- }
                    -- require("telescope.builtin").find_files {
                    --     cwd = require("oil").get_current_dir(),
                    -- }
                end,
                mode = { "n" },
                nowait = true,
                desc = "FFFind files in the current oil directory",
            },
            ["<leader>sg"] = {
                function()
                    require("fff").live_grep {
                        ---@diagnostic disable-next-line
                        cwd = require("oil").get_current_dir(),
                    }
                    -- ---@diagnostic disable-next-line
                    -- Snacks.picker.grep {
                    --     cwd = require("oil").get_current_dir(),
                    -- }
                    -- require("telescope.builtin").live_grep {
                    --     cwd = require("oil").get_current_dir(),
                    -- }
                end,
                mode = "n",
                nowait = true,
                desc = "Live grep in the current oil directory",
            },
        },
    },
    init = function()
        vim.keymap.set(
            "n",
            "-",
            require("oil").open,
            { desc = "Oil: Open parent directory" }
        )
    end,
}
