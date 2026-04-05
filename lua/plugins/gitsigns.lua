---@module "lazy"
---@type LazySpec
return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    ---@module "gitsigns"
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        current_line_blame = true,
        on_attach = function(bufnr)
            local gitsigns = require "gitsigns"

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Naviagtion
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal { "]c", bang = true }
                else
                    gitsigns.nav_hunk "next"
                end
            end, { desc = "Move to next git [c]hange" })

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal { "[c", bang = true }
                else
                    gitsigns.nav_hunk "prev"
                end
            end, { desc = "Move to previous git [c]hange" })

            -- Actions
            -- Visual mode
            map("v", "<leader>gs", function()
                gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
            end, { desc = "[G]it [s]tage change" })
            map("v", "<leader>gr", function()
                gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
            end, { desc = "[G]it [r]eset change" })
            -- Normal mode
            -- map(
            --     "n",
            --     "<leader>hs",
            --     gitsigns.stage_hunk,
            --     { desc = "git [s]tage hunk" }
            -- )
            -- map(
            --     "n",
            --     "<leader>hr",
            --     gitsigns.reset_hunk,
            --     { desc = "git [r]eset hunk" }
            -- )
            -- map(
            --     "n",
            --     "<leader>hS",
            --     gitsigns.stage_buffer,
            --     { desc = "git [S]tage buffer" }
            -- )
            -- map(
            --     "n",
            --     "<leader>hR",
            --     gitsigns.reset_buffer,
            --     { desc = "git [R]eset buffer" }
            -- )
            -- map(
            --     "n",
            --     "<leader>hp",
            --     gitsigns.preview_hunk,
            --     { desc = "[G]it [p]review changes" }
            -- )
            map(
                "n",
                "<leader>gi",
                gitsigns.preview_hunk_inline,
                { desc = "[G]it preview changes [i]nline" }
            )
            -- map("n", "<leader>hb", function()
            --     gitsigns.blame_line { full = true }
            -- end, { desc = "git [b]lame line" })
            -- map(
            --     "n",
            --     "<leader>hd",
            --     gitsigns.diffthis,
            --     { desc = "git [d]iff against index" }
            -- )
            -- map("n", "<leader>hD", function()
            --     gitsigns.diffthis "@"
            -- end, { desc = "git [D]iff against last commit" })
            -- map("n", "<leader>hQ", function()
            --     gitsigns.setqflist "all"
            -- end)
            -- map("n", "<leader>hq", gitsigns.setqflist)
            -- Toggles
            map(
                "n",
                "<leader>tb",
                gitsigns.toggle_current_line_blame,
                { desc = "[G]it [t]oggle show [b]lame line" }
            )
            map("n", "<leader>tw", gitsigns.toggle_word_diff)
            -- Text object
            map(
                { "o", "x" },
                "ih",
                gitsigns.select_hunk,
                { desc = "[G]it select hunk" }
            )
        end,
    },
}
