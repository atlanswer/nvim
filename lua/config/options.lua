do
    vim.loader.enable()

    -- <space> as the leader key
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    vim.g.have_nerd_font = true

    vim.opt.fileformats = "unix,dos"

    vim.opt.linebreak = true

    vim.opt.number = true
    vim.opt.relativenumber = true

    vim.opt.cindent = true
    vim.opt.breakindent = true
    vim.opt.breakindentopt = "list:-1"

    vim.opt.mouse = "a"

    -- Replaced by status line
    vim.opt.showmode = false

    vim.opt.scrolloff = 10

    vim.opt.inccommand = "split"
    vim.opt.incsearch = true

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true

    vim.opt.switchbuf = "usetab"
    vim.opt.shada = "'100,<50,s10,:100,/100,@100,h,ra:,rb:,r/tmp"

    vim.opt.swapfile = false
    vim.opt.undofile = true

    vim.opt.confirm = true

    vim.opt.ignorecase = true
    vim.opt.smartcase = true

    vim.opt.signcolumn = "yes"
    vim.opt.colorcolumn = "81"

    vim.opt.updatetime = 250
    vim.opt.timeoutlen = 500

    vim.opt.splitkeep = "screen"
    vim.opt.splitbelow = true
    vim.opt.splitright = true

    vim.opt.list = true
    vim.opt.listchars = {
        tab = "» ",
        trail = "·",
        nbsp = "␣",
        extends = "…",
        precedes = "…",
    }

    -- Default fold
    -- vim.opt.foldenable = false
    vim.opt.foldlevel = 10
    vim.opt.foldmethod = "indent"
    vim.opt.foldnestmax = 10
    vim.opt.foldtext = ""

    vim.opt.hlsearch = true
    vim.opt.termguicolors = true

    vim.opt.cursorline = true
    vim.opt.cursorlineopt = "screenline,number"
    vim.opt.guicursor = "a:Cursor/lCursor,\z
                     n-v-c:block,\z
                     i-ci-ve:ver25-blinkwait0-blinkoff500-blinkon500,\z
                     r-cr-o:hor20,\z
                     sm:blinkwait0-blinkoff500-blinkon500,\z
                     t:TermCursor"

    vim.opt.pumheight = 10

    vim.opt.winborder = "rounded"

    -- Per directory overrides
    vim.opt.exrc = true
end
