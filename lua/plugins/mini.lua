return { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        require("mini.ai").setup {
            -- Table with textobject id as fields, textobject specification as values.
            -- Also use this to disable builtin textobjects. See |MiniAi.config|.
            custom_textobjects = {
                p = require("mini.ai").gen_spec.function_call {},
                -- p = require("mini.ai").gen_spec.treesitter {
                --     a = "@parameter.outer",
                --     i = "@parameter.inner",
                -- },
                f = require("mini.ai").gen_spec.treesitter {
                    a = "@function.outer",
                    i = "@function.inner",
                },
            },
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Main textobject prefixes
                around = "a",
                inside = "i",
                -- Next/last textobjects
                -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
                -- Map LSP selection manually to use it (see `:h MiniAi.config`)
                around_next = "an",
                inside_next = "in",
                around_last = "al",
                inside_last = "il",
                -- Move cursor to corresponding edge of `a` textobject
                goto_left = "[[",
                goto_right = "]]",
            },
            -- Number of lines within which textobject is searched
            n_lines = 100,
            -- How to search for object (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
            search_method = "cover_or_next",
            -- Whether to disable showing non-error feedback
            -- This also affects (purely informational) helper messages shown after
            -- idle time if user input is required.
            silent = false,
        }

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        local statusline = require "mini.statusline"
        statusline.setup()
        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we disable the section for
        -- cursor information because line numbers are already enabled
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function(args)
            -- Use virtual column number to allow update when past last column
            if MiniStatusline.is_truncated(args.trunc_width) then
                return "%l:%v/%L"
            end
            -- Use `virtcol()` to correctly handle multi-byte characters
            -- return '%2l:%-v / %L:%-2{virtcol("$") - 1}'
            return "[%P] %2l:%-2v/%-2L"
        end

        require("mini.tabline").setup()
        vim.o.showtabline = 1

        require("mini.comment").setup {
            options = {
                -- Whether to ignore blank lines when commenting
                ignore_blank_line = true,
                -- Whether to ignore blank lines in actions and textobject
                start_of_line = false,
                -- Whether to force single space inner padding for comment parts
                pad_comment_parts = true,
            },
        }
    end,
}
