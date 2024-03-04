return { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VimEnter",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "html", "lua", "markdown", "vim", "vimdoc",
          "typescript", "javascript", "json",
          "python",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
        },
      }
      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
    cond = not vim.g.vscode,
}
