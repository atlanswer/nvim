return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require("mini.surround").setup {
        mappings = {
            add = "ys", -- Add surrounding in Normal and Visual modes
            delete = "ds", -- Delete surrounding
            find = "fs", -- Find surrounding (to the right)
            find_left = "Fs", -- Find surrounding (to the left)
            highlight = "", -- Highlight surrounding
            replace = "rs", -- Replace surrounding
            update_n_lines = "ns", -- Update `n_lines`
            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
        },
      }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require "mini.statusline"
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we disable the section for
      -- cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ""
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}
