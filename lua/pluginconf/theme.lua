-- 基础环境
vim.opt.termguicolors = false
vim.opt.background = "dark"
vim.highlight.priorities.semantic_tokens = 95
vim.highlight.priorities.treesitter = 50

-- Gruvbox（256 色友好）
local ok, gruvbox = pcall(require, "gruvbox")
if ok then
  gruvbox.setup({
    terminal_colors = true,
    contrast = "hard",
    overrides = {
      Normal     = { bg = "NONE", ctermbg = "NONE" },
      SignColumn = { bg = "NONE", ctermbg = "NONE" },
      FoldColumn = { bg = "NONE", ctermbg = "NONE" },
      Comment    = { italic = true, fg = "#928374", ctermfg = 246 },
    },
  })
end
vim.cmd("colorscheme gruvbox")

-- Treesitter 兜底
local links = {
  ["@comment"]     = "Comment",
  ["@string"]      = "String",
  ["@number"]      = "Number",
  ["@boolean"]     = "Boolean",
  ["@constant"]    = "Constant",
  ["@operator"]    = "Operator",
  ["@punctuation"] = "Delimiter",
}
for ts, g in pairs(links) do
  vim.api.nvim_set_hl(0, ts, { link = g })
end

-- Go 语义高亮（256 色优化 & 更突出）
local p = {
  fg       = "#1c1c1c", -- 默认文字，深灰
  gray     = "#7c7c7c", -- 注释
  red      = "#9d0006", -- 关键字 / 控制流
  orange   = "#d65d0e", -- 字符串 / 数字
  yellow   = "#e7c547", -- 类型 / 构造函数
  green    = "#4f8a10", -- 普通函数
  cyan     = "#2aa198", -- 字段 / 属性
  blue     = "#268bd2", -- 参数 / 包名
  purple   = "#6c71c4", -- 接口方法 / 布尔
  bg       = "#fdf6e3", -- 背景，亮米色
}

-- =========================
-- LSP 高亮（优先）
-- =========================
vim.api.nvim_set_hl(0, "@lsp.type.namespace.go",   { fg = p.blue,   ctermfg = 33 })       -- 包 / 命名空间
vim.api.nvim_set_hl(0, "@lsp.type.constructor.go", { fg = p.yellow, ctermfg = 220, bold = true })  -- 构造函数
vim.api.nvim_set_hl(0, "@lsp.type.function.go",    { fg = p.green,  ctermfg = 34, bold = true })   -- 函数
vim.api.nvim_set_hl(0, "@lsp.type.method.go",      { fg = p.green,  ctermfg = 34, italic = true }) -- 方法
vim.api.nvim_set_hl(0, "@lsp.type.parameter.go",   { fg = p.blue,   ctermfg = 33, italic = true }) -- 参数
vim.api.nvim_set_hl(0, "@lsp.type.property.go",    { fg = p.cyan,   ctermfg = 37 })                 -- 字段 / 属性

-- =========================
-- Treesitter 高亮兜底
-- =========================
vim.api.nvim_set_hl(0, "@namespace.go", { fg = p.blue, ctermfg = 33, bg = p.bg })
vim.api.nvim_set_hl(0, "@function.go",  { fg = p.yellow, ctermfg = 220, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@method.go",    { fg = p.green, ctermfg = 34, italic = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@function.method.interface.go", { fg = p.purple, ctermfg = 141, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@parameter.go", { fg = p.blue, ctermfg = 33, italic = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@field.go",     { fg = p.cyan, ctermfg = 37, bg = p.bg })
vim.api.nvim_set_hl(0, "@constant.go",  { fg = p.yellow, ctermfg = 220, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@boolean.go",   { fg = p.purple, ctermfg = 141, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@string.go",    { fg = p.orange, ctermfg = 214, bg = p.bg })
vim.api.nvim_set_hl(0, "@number.go",    { fg = p.orange, ctermfg = 214, bg = p.bg })
vim.api.nvim_set_hl(0, "@keyword.go",   { fg = p.red, ctermfg = 124, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "@keyword.return.go", { fg = p.red, ctermfg = 124, bold = true, bg = p.bg })
vim.api.nvim_set_hl(0, "Comment",       { fg = p.gray, ctermfg = 246, italic = true, bg = p.bg })

-- 默认文字 & 背景
vim.api.nvim_set_hl(0, "SignColumn", { bg = p.bg, ctermbg = 230 })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = p.bg, ctermbg = 230 })

-- 启动语法
vim.cmd("syntax on")
