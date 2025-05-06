return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "diff",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "query",
            "vim",
            "vimdoc",
            "html",
            "javascript",
            "typescript",
        },
        -- Autoinstall languages that are not installed
        auto_install = false,
        highlight = {
            enable = true,
            -- NOTE: these are the names of the parsers and not the filetype.
            -- (for example if you want to disable highlighting for the `tex` filetype,
            -- you need to include `latex` in this list as this is the name of the parser)
            -- Or use a function for more flexibility,
            -- e.g. to disable slow treesitter highlight for large files
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats =
                    pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
    },
}
