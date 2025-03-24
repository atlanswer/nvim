-- Map Typst Preview

vim.keymap.set(
    "n",
    "<A-P>",
    vim.cmd.TypstPreviewToggle,
    { desc = "Toggle Typst [P]review" }
)

vim.opt.backupcopy = "yes"
