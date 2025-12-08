return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    cond = not vim.g.vscode,
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            layout = function()
                return vim.o.columns >= 120 and "horizontal" or "vertical"
            end,
            layouts = {
                horizontal = {
                    cycle = true,
                    reverse = true,
                    layout = {
                        box = "horizontal",
                        width = 0.8,
                        min_width = 96,
                        height = 0.8,
                        {
                            box = "vertical",
                            border = true,
                            { win = "list" },
                            {
                                win = "input",
                                title = "{title} {live} {flags}",
                                title_pos = "center",
                                height = 1,
                                border = "top",
                            },
                        },
                        {
                            win = "preview",
                            title = "{preview}",
                            width = 0.5,
                            border = true,
                        },
                    },
                },
                vertical = {
                    cycle = true,
                    reverse = true,
                    layout = {
                        box = "vertical",
                        border = true,
                        title = "{preview}",
                        title_pos = "center",
                        width = 0.5,
                        min_width = 80,
                        height = 0.8,
                        min_height = 30,
                        {
                            win = "preview",
                            height = 0.4,
                            border = "bottom",
                        },
                        { win = "list" },
                        {
                            win = "input",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            height = 1,
                            border = "top",
                        },
                    },
                },
            },
        },
        notifier = { enabled = true, style = "fancy" },
        -- zen = {},
    },
    init = function()
        -- Advanced LSP Progress
        ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
        local progress = vim.defaulttable()
        vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                if not client or type(value) ~= "table" then
                    return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                    if i == #p + 1 or p[i].token == ev.data.params.token then
                        p[i] = {
                            token = ev.data.params.token,
                            msg = ("[%3d%%] %s%s"):format(
                                value.kind == "end" and 100
                                    or value.percentage
                                    or 100,
                                value.title or "",
                                value.message
                                        and (" **%s**"):format(value.message)
                                    or ""
                            ),
                            done = value.kind == "end",
                        }
                        break
                    end
                end

                local msg = {} ---@type string[]
                progress[client.id] = vim.tbl_filter(function(v)
                    return table.insert(msg, v.msg) or not v.done
                end, p)

                local spinner = {
                    "⠋",
                    "⠙",
                    "⠹",
                    "⠸",
                    "⠼",
                    "⠴",
                    "⠦",
                    "⠧",
                    "⠇",
                    "⠏",
                }
                vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
                    id = "lsp_progress",
                    title = client.name,
                    opts = function(notif)
                        notif.icon = #progress[client.id] == 0 and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })
        -- Notifications command
        vim.api.nvim_create_user_command("Notifications", function()
            Snacks.notifier.show_history()
        end, { desc = "Show notification history" })
    end,
    keys = {
        -- Pickers
        {
            "<leader><leader>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Snacks Picker: Smart find files",
        },
        {
            "<leader>sf",
            function()
                Snacks.picker.files()
            end,
            desc = "Snacks Picker: Find files",
        },
        {
            "<leader>sn",
            function()
                Snacks.picker.files { cwd = vim.fn.stdpath "config" }
            end,
            desc = "Snacks Picker: Find Neovim config files",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Snacks Picker: Grep",
        },
        {
            "<leader>s.",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        {
            "<leader>s/",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Snacks Picker: Buffers",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Snacks Picker: Command history",
        },
        {
            "<leader>n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Snacks Picker: Notification history",
        },
        {
            "<leader>gg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Snacks Picker: Find Git files",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Snacks Picker: Git status",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Snacks Picker: Git diff (hunks)",
        },
        {
            "<leader>gl",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Snacks Picker: Git log",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Snacks Picker: Git log for current file",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Search: Help pages",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Search: Keymaps",
        },
        {
            "<leader>sb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Search: Lines in current buffer",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep: Opened buffers",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            mode = { "n", "x" },
            desc = "Search: Visual selection or word",
        },
        {
            '<leader>s"',
            function()
                Snacks.picker.registers()
            end,
            desc = "Search: Registers",
        },
        {
            "<leader>sa",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Search: Autocmds",
        },
        {
            "<leader>se",
            function()
                Snacks.picker.explorer()
            end,
            desc = "Snacks Picker: Explorer",
        },
        {
            "<leader>sc",
            function()
                Snacks.picker.commands()
            end,
            desc = "Search: Commands",
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Search: Diagnostics",
        },
        {
            "<leader>sD",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Search: Buffer diagnostics",
        },
        {
            "<leader>sq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Search: Quickfix list",
        },
        {
            "<leader>sj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Search: Jumps",
        },
        {
            "<leader>sl",
            function()
                Snacks.picker.loclist()
            end,
            desc = "Search: Location list",
        },
        {
            "<leader>gp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Snacks Picker: Projects",
        },
        {
            "<leader>sR",
            function()
                Snacks.picker.resume()
            end,
            desc = "Snacks Picker: Resume",
        },
        {
            "<leader>su",
            function()
                Snacks.picker.undo()
            end,
            desc = "Snacks Picker: Undo history",
        },
        -- LSP: https://neovim.io/doc/user/lsp.html
        -- "gra" -> vim.lsp.buf.code_action()
        -- "gri" -> vim.lsp.buf.implementation()
        -- "grn" -> vim.lsp.buf.rename()
        -- "grr" -> vim.lsp.buf.references()
        -- "grt" -> vim.lsp.buf.type_definition()
        -- "gO"  -> vim.lsp.buf.document_symbol()
        -- CTRL-S (insert mode) -> vim.lsp.buf.signature_help()
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto declaration",
        },
        {
            "grr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "Goto references",
        },
        {
            "gri",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto implementation",
        },
        {
            "grt",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto type definition",
        },
        {
            "gO",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP symbols",
        },
        {
            "gW",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP workspace symbols",
        },
        {
            "gai",
            function()
                Snacks.picker.lsp_incoming_calls()
            end,
            desc = "C[a]lls Incoming",
        },
        {
            "gao",
            function()
                Snacks.picker.lsp_outgoing_calls()
            end,
            desc = "C[a]lls Outgoing",
        },
        -- Bufdelete
        {
            "<leader>bd",
            function()
                Snacks.bufdelete.delete()
            end,
            mode = { "n" },
            desc = "Delete buffer without disrupting window layout",
        },
    },
}
