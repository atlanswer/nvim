return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-frecency.nvim",
    },
    cond = not vim.g.vscode,
    config = function()
        local telescope = require "telescope"
        local telescipeConfig = require "telescope.config"
        local themes = require "telescope.themes"
        local actions = require "telescope.actions"
        local layout = require "telescope.actions.layout"
        local layout_strategies = require "telescope.pickers.layout_strategies"

        local vimgrep_arguments =
            { unpack(telescipeConfig.values.vimgrep_arguments) }
        table.insert(vimgrep_arguments, "--hidden")
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup {
            defaults = {
                layout_strategy = "flex",
                layout_config = {
                    flip_columns = 120,
                    flip_lines = 0,
                    horizontal = {
                        preview_cutoff = 120,
                    },
                    vertical = {
                        preview_cutoff = 20,
                    },
                },
                vimgrep_arguments = vimgrep_arguments,
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-l>"] = layout.toggle_preview,
                        ["<C-h>"] = actions.select_horizontal,
                        ["<C-j>"] = actions.select_vertical,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob",
                        "!**/.git/*",
                    },
                },
                buffers = {
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer
                                + actions.move_to_top,
                        },
                    },
                },
            },
        }

        -- Enable telescope extensions, if they are installed
        telescope.load_extension "ui-select"
        telescope.load_extension "notify"
        telescope.load_extension "frecency"

        -- See `:help telescope.builtin`
        local builtin = require "telescope.builtin"
        vim.keymap.set(
            "n",
            "<leader>sh",
            builtin.help_tags,
            { desc = "[S]earch [H]elp" }
        )
        vim.keymap.set(
            "n",
            "<leader>sk",
            builtin.keymaps,
            { desc = "[S]earch [K]eymaps" }
        )
        vim.keymap.set(
            "n",
            "<leader>sf",
            builtin.find_files,
            { desc = "[S]earch [F]iles" }
        )
        vim.keymap.set(
            "n",
            "<leader>ss",
            builtin.builtin,
            { desc = "[S]earch [S]elect Telescope" }
        )
        vim.keymap.set(
            "n",
            "<leader>sc",
            builtin.commands,
            { desc = "[S]earch [C]ommands" }
        )
        vim.keymap.set(
            "n",
            "<leader>sw",
            builtin.grep_string,
            { desc = "[S]earch current [W]ord" }
        )
        vim.keymap.set(
            "n",
            "<leader>sg",
            builtin.live_grep,
            { desc = "[S]earch by [G]rep" }
        )
        vim.keymap.set("n", "<leader>s/", function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            }
        end, { desc = "[S]earch [/] in Open Files" })
        vim.keymap.set(
            "n",
            "<leader>sd",
            builtin.diagnostics,
            { desc = "[S]earch [D]iagnostics" }
        )
        vim.keymap.set(
            "n",
            "<leader>sr",
            builtin.resume,
            { desc = "[S]earch [R]esume" }
        )
        vim.keymap.set(
            "n",
            "<leader>s.",
            builtin.oldfiles,
            { desc = '[S]earch Recent Files ("." for repeat)' }
        )
        vim.keymap.set(
            "n",
            "<leader><leader>",
            builtin.buffers,
            { desc = "[ ] Find existing buffers" }
        )
        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(
                require("telescope.themes").get_dropdown { previewer = false }
            )
        end, { desc = "[/] Fuzzily search in current buffer" })
        vim.keymap.set("n", "<leader>sn", function()
            builtin.find_files { cwd = vim.fn.stdpath "config" }
        end, { desc = "[S]earch [N]eovim files" })
        vim.keymap.set(
            "n",
            "<leader>gs",
            builtin.git_status,
            { desc = "[G]it [S]tatus" }
        )
        vim.keymap.set(
            "n",
            "<leader>gb",
            builtin.git_branches,
            { desc = "[G]it [B]ranches" }
        )
        vim.keymap.set(
            "n",
            "<leader>gc",
            builtin.git_commits,
            { desc = "[G]it [C]ommits" }
        )
        vim.keymap.set(
            "n",
            "<leader>gm",
            builtin.git_bcommits,
            { desc = "[G]it bco[M]mits" }
        )
        vim.keymap.set(
            "n",
            "<leader>gh",
            builtin.git_stash,
            { desc = "[G]it stas[H]" }
        )
    end,
}
