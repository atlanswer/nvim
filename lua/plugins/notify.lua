return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    ---@module "notify"
    ---@type notify.Config
    opts = {
        top_down = false,
        stages = "fade",
    },
    init = function()
        vim.notify = require "notify"
        vim.lsp.handlers["textDocument/hover"] = function(
            _,
            result,
            ctx,
            config
        )
            config = config or {}
            config.focus_id = ctx.method
            if not (result and result.contents) then
                return
            end
            local markdown_lines =
                vim.lsp.util.convert_input_to_markdown_lines(result.contents)
            local markdown_line = vim.fn.join(markdown_lines)
            markdown_line = vim.split(markdown_line, "", { trimempty = true })
            if vim.tbl_isempty(markdown_line) then
                return
            end
            return vim.lsp.handlers.hover(_, result, ctx, config)
        end
    end,
    cond = not vim.g.vscode,
}

