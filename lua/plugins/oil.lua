return {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.nvim", opts = {} } },
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
                    require("telescope.builtin").find_files {
                        cwd = require("oil").get_current_dir(),
                    }
                end,
                mode = "n",
                nowait = true,
                desc = "[S]earch [F]iles in the current directory",
            },
            ["<leader>sg"] = {
                function()
                    require("telescope.builtin").live_grep {
                        cwd = require("oil").get_current_dir(),
                    }
                end,
                mode = "n",
                nowait = true,
                desc = "Live [G]rep in the current directory",
            },
        },
    },
    init = function()
        vim.keymap.set(
            "n",
            "-",
            require("oil").open,
            { desc = "(Oil) Open parent directory" }
        )
    end,
}
