return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup { n_lines = 300 }

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        local statusline = require "mini.statusline"
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we disable the section for
        -- cursor information because line numbers are already enabled
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        require("mini.tabline").setup()
    end,
}
