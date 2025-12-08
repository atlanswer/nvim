return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
        cond = not vim.g.vscode,
    },
    { -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            { "mason-org/mason.nvim", opts = {}, event = "VeryLazy" },
        },
        cond = not vim.g.vscode,
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup(
                    "kickstart-lsp-attach",
                    { clear = true }
                ),
                callback = function(event)
                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client:supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight,
                            event.buf
                        )
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            "kickstart-lsp-highlight",
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd(
                            { "CursorHold", "CursorHoldI" },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )
                        vim.api.nvim_create_autocmd(
                            { "CursorMoved", "CursorMovedI" },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )
                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = vim.api.nvim_create_augroup(
                                "kickstart-lsp-detach",
                                { clear = true }
                            ),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds {
                                    group = "kickstart-lsp-highlight",
                                    buffer = event2.buf,
                                }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code
                    if
                        client
                        and client:supports_method(
                            vim.lsp.protocol.Methods.textDocument_inlayHint,
                            event.buf
                        )
                    then
                        vim.keymap.set({ "n" }, "<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled {
                                    bufnr = event.buf,
                                }
                            )
                        end, {
                            desc = "Toggle inlay hints",
                        })
                    end
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font
                        and {
                            text = {
                                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                                [vim.diagnostic.severity.WARN] = "󰀪 ",
                                [vim.diagnostic.severity.INFO] = "󰋽 ",
                                [vim.diagnostic.severity.HINT] = "󰌶 ",
                            },
                        }
                    or {},
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }

            -- Check OS and arch
            -- local function isWindowsARM64()
            --     local platform = string.lower(jit.os)
            --     local arch = string.lower(jit.arch)
            --     return platform:find "windows" and arch == "arm64"
            -- end

            -- Enable the following language servers
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --  For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- gopls = {},
                -- rust_analyzer = {},
                -- basedpyright = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            diagnostics = { disable = { "missing-fields" } },
                        },
                    },
                },
                clangd = {},
                zls = {},
                bashls = {
                    cmd = { "bunx", "--bun", "bash-language-server", "start" },
                },
                jsonls = {
                    cmd = {
                        "bunx",
                        "--bun",
                        "-p",
                        "vscode-langservers-extracted",
                        "vscode-json-language-server",
                        "--stdio",
                    },
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas {
                                ignore = {},
                            },
                            validate = { enable = true },
                        },
                    },
                },
                html = {
                    cmd = {
                        "bunx",
                        "--bun",
                        "-p",
                        "vscode-langservers-extracted",
                        "vscode-html-language-server",
                        "--stdio",
                    },
                },
                cssls = {
                    cmd = {
                        "bunx",
                        "--bun",
                        "-p",
                        "vscode-langservers-extracted",
                        "vscode-css-language-server",
                        "--stdio",
                    },
                },
                tailwindcss = {
                    cmd = {
                        "bunx",
                        "--bun",
                        "-p",
                        "@tailwindcss/language-server",
                        "tailwindcss-language-server",
                        "--stdio",
                    },
                },
                astro = {
                    cmd = {
                        "bunx",
                        "--bun",
                        "-p",
                        "@astrojs/language-server",
                        "astro-ls",
                        "--stdio",
                    },
                },
                ruff = {
                    cmd = { "uvx", "ruff", "server" },
                },
                ty = {
                    cmd = { "uvx", "ty", "server" },
                },
                -- eslint = {
                --     settings = {
                --         format = {
                --             enable = false,
                --         },
                --         experimental = {
                --             useFlatConfig = true,
                --         },
                --     },
                -- },
                -- taplo = {}
                -- tinymist = {
                --     settings = {
                --         formatterMode = "typstyle",
                --         formatterPrintWidth = 80,
                --     },
                -- },
                -- neocmake = {
                --     capabilities = {
                --         workspace = {
                --             didChangeWatchedFiles = {
                --                 dynamicRegistration = true,
                --                 relative_pattern_support = true,
                --             },
                --         },
                --         textDocument = {
                --             completion = {
                --                 completionItem = {
                --                     snippetSupport = true,
                --                 },
                --             },
                --         },
                --     },
                --     init_options = {
                --         format = {
                --             enable = true, -- to use lsp format
                --         },
                --         lint = {
                --             enable = true,
                --         },
                --         scan_cmake_in_package = false, -- it will deeply check the cmake file which found when search cmake packages.
                --         semantic_token = false,
                --         -- semantic_token heighlight. if you use treesitter highlight, it is suggested to set with false. it can be used to make better highlight for vscode which only has textmate highlight
                --     },
                -- },
            }

            -- Enable all language servers
            for server_name, server in pairs(servers) do
                server.capabilities = require("blink-cmp").get_lsp_capabilities(
                    server.capabilities
                )
                vim.lsp.config(server_name, server)
                vim.lsp.enable(server_name)
            end
        end,
    },
}
