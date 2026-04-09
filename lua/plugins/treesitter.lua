return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    cond = not vim.g.vscode,
    branch = "main",
    build = ":TSUpdate",
    opts = {},
    init = function()
        local parsers = {
            "lua",
            "luadoc",
            "vim",
            "vimdoc",
            "diff",
            "query",
            "markdown",
            "zig",
            "c",
            "cpp",
            "cmake",
            "rust",
            "json",
            "html",
            "css",
            "javascript",
            "jsdoc",
            "typescript",
            "tsx",
            "astro",
            "python",
            "toml",
            "yaml",
            "ssh_config",
            "git_config",
            "gitcommit",
            "git_rebase",
            "gitignore",
            "gitattributes",
            "editorconfig",
            "bash",
            "zsh",
            "powershell",
            "hyprlang",
            "latex",
            "kotlin",
        }
        require("nvim-treesitter").install(parsers)

        ---@param buf integer
        ---@param language string
        local function treesitter_try_attach(buf, language)
            -- Check if parser exists and load it
            if not vim.treesitter.language.add(language) then
                return
            end
            -- Enables syntax highlighting and other treesitter features
            vim.treesitter.start(buf, language)
            -- Enables treesitter based folds
            -- For more info on folds see `:help folds`
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.fillchars = "fold:-"
            -- Enables treesitter based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = require("nvim-treesitter").get_available()

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end

                local installed_parsers =
                    require("nvim-treesitter").get_installed "parsers"

                if vim.tbl_contains(installed_parsers, language) then
                    -- Enable the parser if it is installed
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    -- If a parser is available in `nvim-treesitter`,
                    -- auto install it, and enable it after the installation
                    require("nvim-treesitter").install(language):await(
                        function()
                            treesitter_try_attach(buf, language)
                        end
                    )
                else
                    -- Try to enable treesitter features in case the parser
                    -- exists but is not available in `nvim-treesitter`
                    treesitter_try_attach(buf, language)
                end
            end,
        })
    end,
}
