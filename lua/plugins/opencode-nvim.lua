return {
    "NickvanDyke/opencode.nvim",
    cond = not vim.g.vscode,
    version = "*", -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            "folke/snacks.nvim",
            optional = true,
            opts = {
                input = {}, -- Enhances `ask()`
                picker = { -- Enhances `select()`
                    actions = {
                        opencode_send = function(...)
                            return require("opencode").snacks_picker_send(...)
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ["<a-a>"] = {
                                    "opencode_send",
                                    mode = { "n", "i" },
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    init = function()
        local opencode_cmd = "opencode --port"
        ---@type snacks.terminal.Opts
        local snacks_terminal_opts = {
            win = {
                position = "right",
                enter = false,
            },
        }
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            lsp = { enabled = true },
            server = {
                start = function()
                    require("snacks.terminal").open(
                        opencode_cmd,
                        snacks_terminal_opts
                    )
                end,
            },
            select = { snacks = { layout = { cycle = true } } },
        }
        -- Optionally show upon submitting prompt
        vim.api.nvim_create_autocmd("User", {
            pattern = { "OpencodeEvent:tui.command.execute" },
            callback = function(args)
                ---@type opencode.server.Event
                local event = args.data.event
                if event.properties.command == "prompt.submit" then
                    local win = require("snacks.terminal").get(
                        opencode_cmd,
                        { create = false }
                    )
                    if win then
                        win:show()
                    end
                end
            end,
        })
    end,
    keys = {
        {
            "<C-.>",
            function()
                local opencode_cmd = "opencode --port"
                ---@type snacks.terminal.Opts
                local snacks_terminal_opts = {
                    win = {
                        position = "right",
                        enter = false,
                    },
                }
                require("snacks.terminal").toggle(
                    opencode_cmd,
                    snacks_terminal_opts
                )
            end,
            mode = { "n", "t" },
            desc = "OpenCode: toggle",
        },
        {
            "<leader>oa",
            function()
                require("opencode").ask "@this: "
            end,
            mode = { "n", "x" },
            desc = "OpenCode: ask...",
        },
        {
            "<leader>ox",
            function()
                require("opencode").select()
            end,
            mode = { "n", "x" },
            desc = "OpenCode: select...",
        },
        {
            "<leader>go",
            function()
                return require("opencode").operator "@this "
            end,
            mode = { "n", "x" },
            desc = "OpenCode: add range",
            expr = true,
        },
        {
            "<leader>goo",
            function()
                return require("opencode").operator "@this " .. "_"
            end,
            mode = { "n" },
            desc = "OpenCode: add line",
            expr = true,
        },
        {
            "<S-A-u>",
            function()
                require("opencode").command "session.half.page.up"
            end,
            mode = { "n" },
            desc = "OpenCode: scroll up",
        },
        {
            "<S-A-d>",
            function()
                require("opencode").command "session.half.page.down"
            end,
            mode = { "n" },
            desc = "OpenCode: scroll down",
        },
    },
}
