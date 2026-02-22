return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            opts = {},
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        "folke/lazydev.nvim",
        "echasnovski/mini.nvim",
    },
    -- event = "VimEnter",
    cond = not vim.g.vscode,
    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "super-tab",
            ["<C-o>"] = {
                "show",
                "show_documentation",
                "hide_documentation",
            },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "normal",
        },

        completion = {
            list = {
                selection = { preselect = true, auto_insert = false },
            },
            documentation = {
                window = {
                    border = "rounded",
                },
            },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "kind_icon", "label" },
                        { "kind", "source_name", gap = 1 },
                    },
                    components = {
                        label = {
                            width = { fill = true, min = 10 },
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(
                                    ctx
                                )
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(
                                    ctx
                                )
                            end,
                        },
                        -- kind_icon = {
                        --     text = function(ctx)
                        --         local kind_icon, _, _ =
                        --             require("mini.icons").get("lsp", ctx.kind)
                        --         return kind_icon
                        --     end,
                        --     -- (optional) use highlights from mini.icons
                        --     highlight = function(ctx)
                        --         local _, hl, _ =
                        --             require("mini.icons").get("lsp", ctx.kind)
                        --         return hl
                        --     end,
                        -- },
                        -- kind = {
                        --     -- (optional) use highlights from mini.icons
                        --     highlight = function(ctx)
                        --         local _, hl, _ =
                        --             require("mini.icons").get("lsp", ctx.kind)
                        --         return hl
                        --     end,
                        -- },
                    },
                },
            },
            ghost_text = { enabled = true },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "lazydev",
                "omni",
                "buffer",
            },
            -- optionally disable cmdline completions
            -- cmdline = {},
            providers = {
                lazydev = {
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },

        snippets = { preset = "luasnip" },

        -- experimental signature help support
        signature = { enabled = true, window = { border = "rounded" } },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" },

        -- Disable for typr
        enabled = function()
            return not vim.tbl_contains({ "typr" }, vim.bo.filetype)
        end,
    },
    opts_extend = { "sources.default" },
}
