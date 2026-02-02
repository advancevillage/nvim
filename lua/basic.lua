-- ~/.config/nvim/lua/basic.lua
-- Neovim 基础配置 (纯 Lua，可直接用，修正 iskeyword / whichwrap)

--========================
----> 折叠
--========================
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99

--========================
----> 显示设置
--========================
vim.opt.number = true               -- 显示行号
vim.opt.ruler = true                -- 显示标尺
vim.opt.mouse = "r"                 -- 鼠标可以任意位置
vim.opt.paste = true
vim.opt.compatible = false          -- 去掉vi兼容模式
vim.opt.visualbell = true           -- 取消闪烁
vim.opt.cmdheight = 2               -- 命令行高度
vim.opt.wildmenu = true             -- 命令补全增强
vim.opt.backspace = { "indent", "eol", "start" }  -- backspace 行为

vim.opt.cursorline = true           -- 当前行高亮
vim.opt.cursorcolumn = true         -- 当前列高亮
vim.opt.showmode = true             -- 显示模式
vim.opt.background = "light"        -- 背景颜色

vim.opt.magic = true                -- 正则匹配规则
vim.opt.history = 500               -- 历史记录行数
vim.opt.report = 0                  -- 修改行数小于 report 不显示

--========================
----> 文件设置
--========================
vim.opt.confirm = true              -- 保存或只读弹窗确认
vim.opt.clipboard = "unnamed"       -- 系统剪贴板
vim.opt.viminfo:append("!")         -- 保存全局变量
vim.opt.backup = false               -- 不生成备份文件
vim.opt.swapfile = false             -- 不生成 swap 文件

--========================
----> 自动缩进 & Tab 设置
--========================
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 修正 iskeyword 写法 (完全 Lua 可用)
vim.opt.iskeyword:append("_")
vim.opt.iskeyword:append("@")
vim.opt.iskeyword:append("$")
vim.opt.iskeyword:append("%")
vim.opt.iskeyword:append("#")
vim.opt.iskeyword:append("-")

-- 修正 whichwrap 写法 (完全 Lua 可用)
vim.opt.whichwrap:append("<")
vim.opt.whichwrap:append(">")
vim.opt.whichwrap:append("h")
vim.opt.whichwrap:append("l")
vim.opt.whichwrap:append("b")
vim.opt.whichwrap:append("s")
vim.opt.whichwrap:append("[")
vim.opt.whichwrap:append("]")

vim.opt.formatoptions = "tcrqn"     -- 自动格式化选项
vim.opt.autoindent = true
vim.opt.wrap = false

--========================
----> 搜索设置
--========================
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.incsearch = true
vim.opt.ambiwidth = "double"

--========================
----> 特定文件类型设置 (Go 示例)
--========================
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.foldmethod = "syntax"
    end
})
