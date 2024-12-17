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
    end,
    cond = not vim.g.vscode,
}
