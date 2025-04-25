return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup { n_lines = 300 }

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
                return "%l:%-v/%L"
            end
            -- Use `virtcol()` to correctly handle multi-byte characters
            return '%2l:%-v / %L:%-2{virtcol("$") - 1}'
        end

        require("mini.tabline").setup()
        vim.o.showtabline = 1

        require("mini.comment").setup {
            options = {
                ignore_blank_line = true,
            },
        }
    end,
}
