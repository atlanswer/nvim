return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    config = function()
        require("gitsigns").setup {
            current_line_blame = true,
            on_attach = function(bufnr)
                local gitsigns = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "]c", bang = true }
                    else
                        gitsigns.nav_hunk "next"
                    end
                end, { desc = "Move to next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal { "[c", bang = true }
                    else
                        gitsigns.nav_hunk "prev"
                    end
                end, { desc = "Move to previous hunk" })

                -- Actions
                -- visual mode
                map("v", "<leader>gs", function()
                    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Git: Stage hunk" })
                map("v", "<leader>gr", function()
                    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end, { desc = "Git: Reset hunk" })
                -- map(
                --     "n",
                --     "<leader>hs",
                --     gitsigns.stage_hunk,
                --     { desc = "[S]tage hunk" }
                -- )
                -- map(
                --     "n",
                --     "<leader>hr",
                --     gitsigns.reset_hunk,
                --     { desc = "[R]eset hunk" }
                -- )
                -- map(
                --     "n",
                --     "<leader>hS",
                --     gitsigns.stage_buffer,
                --     { desc = "[S]tage buffer" }
                -- )
                -- map(
                --     "n",
                --     "<leader>hu",
                --     gitsigns.undo_stage_hunk,
                --     { desc = "[U]nstage hunk" }
                -- )
                -- map(
                --     "n",
                --     "<leader>hR",
                --     gitsigns.reset_buffer,
                --     { desc = "[R]eset buffer" }
                -- )
                -- map(
                --     "n",
                --     "<leader>hp",
                --     gitsigns.preview_hunk,
                --     { desc = "[Preview] hunk" }
                -- )
                -- map("n", "<leader>hb", function()
                --     gitsigns.blame_line { full = true }
                -- end, { desc = "[B]lame line" })
                map(
                    "n",
                    "<leader>tb",
                    gitsigns.toggle_current_line_blame,
                    { desc = "Git: Toggle current line blame" }
                )
                -- map(
                --     "n",
                --     "<leader>gd",
                --     gitsigns.diffthis,
                --     { desc = "[G]it [D]iff this" }
                -- )
                -- map("n", "<leader>gD", function()
                --     gitsigns.diffthis "~"
                -- end, { desc = "[G]it [D]iff this against ~" })
                map(
                    "n",
                    "<leader>tD",
                    gitsigns.preview_hunk_inline,
                    { desc = "Git: Toggle show deleted" }
                )
                -- Text object
                map(
                    { "o", "x" },
                    "ih",
                    ":<C-U>Gitsigns select_hunk<CR>",
                    { desc = "Git: Select hunk" }
                )
            end,
        }
    end,
}
