-- ~/.config/nvim/lua/basic.lua
local opt = vim.opt

-- General Display
opt.number = true
opt.ruler = true
opt.cursorline = true
opt.cursorcolumn = true
opt.background = "light"
opt.cmdheight = 1          -- 建议设为 1，节省空间
opt.showmode = true
opt.visualbell = true

-- Behavior & Logic
opt.mouse = "r"
opt.paste = false
opt.confirm = true
opt.history = 500
opt.report = 0
opt.clipboard = "unnamed"
opt.backspace = { "indent", "eol", "start" }
opt.whichwrap:append("<,>,h,l,b,s,[,]")
opt.iskeyword:append("_,@,$,%,#,-")

-- Files & Backups
opt.backup = false
opt.swapfile = false
opt.viminfo:append("!")
opt.confirm = true

-- Tabs & Indent
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- Search & Patterns
opt.incsearch = true
opt.showmatch = true
opt.matchtime = 1
opt.magic = true
opt.wrap = false

-- Folds
opt.foldenable = true
opt.foldlevelstart = 99

-- Formatting
opt.formatoptions = "tcrqn"

-- Filetype Autocmds
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        local l = vim.opt_local
        l.tabstop = 4
        l.shiftwidth = 4
        l.softtabstop = 4
        l.foldmethod = "syntax"
    end
})

-- Suppress warnings
vim.g.lspconfig_suppress_deprecation_warnings = true
