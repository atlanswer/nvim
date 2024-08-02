return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {},
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {},
  cond = not vim.g.vscode,
}
