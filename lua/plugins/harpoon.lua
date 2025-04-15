return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    cond = not vim.g.vscode,
    config = function()
        local harpoon = require "harpoon"
        local harpoon_extensions = require "harpoon.extensions"

        harpoon:setup {
            settings = {
                sync_on_ui_close = true,
                key = function()
                    return vim.uv.cwd() or ""
                end,
            },
        }

        harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "[A]dd to harpoon list" })
        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list(), {
                height_in_lines = 16,
            })
        end, { desc = "Toggle [H]arpoon quick menu" })
        vim.keymap.set("n", "gh", function()
            harpoon:list():next { ui_nav_wrap = true }
        end, { desc = "Harpoon next" })
        vim.keymap.set("n", "gy", function()
            harpoon:list():prev { ui_nav_wrap = true }
        end, { desc = "Harpoon previous" })
        vim.keymap.set("n", "g1", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon select file 1" })
        vim.keymap.set("n", "g2", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon select file 2" })
        vim.keymap.set("n", "g3", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon select file 3" })
        vim.keymap.set("n", "g4", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon select file 4" })
    end,
}
