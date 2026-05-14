-- ================================================================
--  nightowl.lua
--  路径: ~/.config/nvim/lua/pluginconf/nightowl.lua
--
--  职责: 仅定义 Go / 通用语义高亮，不做任何 vim.opt 或主题初始化
--  调用: 在 theme.lua 末尾 require("pluginconf.go_highlight").apply()
-- ================================================================

local M = {}

M.apply = function()
  local hl = vim.api.nvim_set_hl

  -- ── 调色板 ──────────────────────────────────────────────────
  -- termguicolors=false 时只有 cterm* 生效；gui* 保留备用
  local p = {
    keyword = { gui = "#ff7b72", cterm = 203 },  -- 关键字 / 控制流
    orange  = { gui = "#f0883e", cterm = 208 },  -- 构造函数 / 类型名
    yellow  = { gui = "#e3b341", cterm = 178 },  -- 数字 / 常量
    func    = { gui = "#7ee787", cterm = 114 },  -- 函数定义
    builtin = { gui = "#79c0ff", cterm = 117 },  -- 内置类型 string/int/error
    pkg     = { gui = "#58a6ff", cterm = 75  },  -- 包名 / 命名空间
    method  = { gui = "#d2a8ff", cterm = 183 },  -- 方法接收者 / 接口方法
    param   = { gui = "#ff9bce", cterm = 218 },  -- 参数名
    field   = { gui = "#76e3ea", cterm = 116 },  -- 字段 / 属性
    str     = { gui = "#a5d6ff", cterm = 153 },  -- 字符串
    comment = { gui = "#6e7681", cterm = 243 },  -- 注释
    number  = { gui = "#e3b341", cterm = 178 },  -- 数字 / 浮点
    err     = { gui = "#f85149", cterm = 203 },
    warn    = { gui = "#e3b341", cterm = 178 },
    hint    = { gui = "#76e3ea", cterm = 116 },
    info    = { gui = "#79c0ff", cterm = 117 },
  }

  -- ── Treesitter 通用兜底（全语言，链接到标准语法组）────────────
  local links = {
    ["@comment"]     = "Comment",
    ["@string"]      = "String",
    ["@number"]      = "Number",
    ["@boolean"]     = "Boolean",
    ["@constant"]    = "Constant",
    ["@operator"]    = "Operator",
    ["@punctuation"] = "Delimiter",
    ["@keyword"]     = "Keyword",
    ["@function"]    = "Function",
    ["@type"]        = "Type",
    ["@variable"]    = "Identifier",
    ["@field"]       = "Identifier",
    ["@parameter"]   = "Identifier",
    ["@namespace"]   = "Include",
  }
  for ts, g in pairs(links) do
    hl(0, ts, { link = g })
  end

  -- ── LSP 语义 Token（优先级 95，gopls 精确类型）───────────────
  hl(0, "@lsp.type.namespace.go",     { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "@lsp.type.package.go",       { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "@lsp.type.type.go",          { fg = p.builtin.gui, ctermfg = p.builtin.cterm, bold = true })
  hl(0, "@lsp.type.interface.go",     { fg = p.builtin.gui, ctermfg = p.builtin.cterm, bold = true, italic = true })
  hl(0, "@lsp.type.struct.go",        { fg = p.orange.gui,  ctermfg = p.orange.cterm,  bold = true })
  hl(0, "@lsp.type.typeParameter.go", { fg = p.builtin.gui, ctermfg = p.builtin.cterm, italic = true })
  hl(0, "@lsp.type.function.go",      { fg = p.func.gui,    ctermfg = p.func.cterm,    bold = true })
  hl(0, "@lsp.type.method.go",        { fg = p.func.gui,    ctermfg = p.func.cterm,    italic = true })
  hl(0, "@lsp.type.constructor.go",   { fg = p.orange.gui,  ctermfg = p.orange.cterm,  bold = true })
  hl(0, "@lsp.type.parameter.go",     { fg = p.param.gui,   ctermfg = p.param.cterm,   italic = true })
  hl(0, "@lsp.type.variable.go",      {})
  hl(0, "@lsp.type.property.go",      { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "@lsp.type.field.go",         { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "@lsp.type.enumMember.go",    { fg = p.yellow.gui,  ctermfg = p.yellow.cterm,  bold = true })
  hl(0, "@lsp.type.keyword.go",       { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@lsp.type.string.go",        { fg = p.str.gui,     ctermfg = p.str.cterm })
  hl(0, "@lsp.type.number.go",        { fg = p.number.gui,  ctermfg = p.number.cterm })
  hl(0, "@lsp.type.boolean.go",       { fg = p.method.gui,  ctermfg = p.method.cterm,  bold = true })
  hl(0, "@lsp.type.comment.go",       { fg = p.comment.gui, ctermfg = p.comment.cterm, italic = true })
  hl(0, "@lsp.type.label.go",         { fg = p.keyword.gui, ctermfg = p.keyword.cterm })
  -- LSP 修饰符叠加
  hl(0, "@lsp.mod.readonly.go",       { bold = true })
  hl(0, "@lsp.mod.deprecated.go",     { strikethrough = true })
  hl(0, "@lsp.mod.defaultLibrary.go", { italic = true })

  -- ── Treesitter Go 专用（优先级 50，LSP 不可用时兜底）────────
  hl(0, "@keyword.go",                   { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@keyword.return.go",            { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@keyword.function.go",          { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@keyword.import.go",            { fg = p.orange.gui,  ctermfg = p.orange.cterm })
  hl(0, "@keyword.conditional.go",       { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@keyword.repeat.go",            { fg = p.keyword.gui, ctermfg = p.keyword.cterm, bold = true })
  hl(0, "@function.go",                  { fg = p.func.gui,    ctermfg = p.func.cterm,    bold = true })
  hl(0, "@function.call.go",             { fg = p.func.gui,    ctermfg = p.func.cterm })
  hl(0, "@method.go",                    { fg = p.func.gui,    ctermfg = p.func.cterm,    italic = true })
  hl(0, "@method.call.go",               { fg = p.func.gui,    ctermfg = p.func.cterm,    italic = true })
  hl(0, "@function.method.interface.go", { fg = p.method.gui,  ctermfg = p.method.cterm,  bold = true })
  hl(0, "@constructor.go",               { fg = p.orange.gui,  ctermfg = p.orange.cterm,  bold = true })
  hl(0, "@namespace.go",                 { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "@module.go",                    { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "@type.go",                      { fg = p.builtin.gui, ctermfg = p.builtin.cterm, bold = true })
  hl(0, "@type.builtin.go",              { fg = p.builtin.gui, ctermfg = p.builtin.cterm })
  hl(0, "@type.definition.go",           { fg = p.orange.gui,  ctermfg = p.orange.cterm,  bold = true })
  hl(0, "@parameter.go",                 { fg = p.param.gui,   ctermfg = p.param.cterm,   italic = true })
  hl(0, "@variable.parameter.go",        { fg = p.param.gui,   ctermfg = p.param.cterm,   italic = true })
  hl(0, "@field.go",                     { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "@variable.member.go",           { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "@property.go",                  { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "@variable.go",                  {})
  hl(0, "@string.go",                    { fg = p.str.gui,     ctermfg = p.str.cterm })
  hl(0, "@string.escape.go",             { fg = p.orange.gui,  ctermfg = p.orange.cterm })
  hl(0, "@number.go",                    { fg = p.number.gui,  ctermfg = p.number.cterm })
  hl(0, "@float.go",                     { fg = p.number.gui,  ctermfg = p.number.cterm })
  hl(0, "@boolean.go",                   { fg = p.method.gui,  ctermfg = p.method.cterm,  bold = true })
  hl(0, "@constant.go",                  { fg = p.yellow.gui,  ctermfg = p.yellow.cterm,  bold = true })
  hl(0, "@operator.go",                  { link = "Operator" })
  hl(0, "@punctuation.delimiter.go",     { link = "Delimiter" })
  hl(0, "@punctuation.bracket.go",       { link = "Delimiter" })
  hl(0, "@comment.go",                   { fg = p.comment.gui, ctermfg = p.comment.cterm, italic = true })
  hl(0, "@comment.documentation.go",     { fg = p.comment.gui, ctermfg = p.comment.cterm, italic = true })

  -- ── 诊断 ────────────────────────────────────────────────────
  hl(0, "DiagnosticError",            { fg = p.err.gui,  ctermfg = p.err.cterm })
  hl(0, "DiagnosticWarn",             { fg = p.warn.gui, ctermfg = p.warn.cterm })
  hl(0, "DiagnosticHint",             { fg = p.hint.gui, ctermfg = p.hint.cterm })
  hl(0, "DiagnosticInfo",             { fg = p.info.gui, ctermfg = p.info.cterm })
  hl(0, "DiagnosticUnderlineError",   { undercurl = true, sp = p.err.gui })
  hl(0, "DiagnosticUnderlineWarn",    { undercurl = true, sp = p.warn.gui })
  hl(0, "DiagnosticUnderlineHint",    { undercurl = true, sp = p.hint.gui })
  hl(0, "DiagnosticUnderlineInfo",    { undercurl = true, sp = p.info.gui })
  hl(0, "DiagnosticVirtualTextError", { fg = p.err.gui,  ctermfg = p.err.cterm,  italic = true })
  hl(0, "DiagnosticVirtualTextWarn",  { fg = p.warn.gui, ctermfg = p.warn.cterm, italic = true })
  hl(0, "DiagnosticVirtualTextHint",  { fg = p.hint.gui, ctermfg = p.hint.cterm, italic = true })
  hl(0, "DiagnosticVirtualTextInfo",  { fg = p.info.gui, ctermfg = p.info.cterm, italic = true })

  -- ── nvim-cmp ─────────────────────────────────────────────────
  hl(0, "CmpSel",                { fg = "#0d1117", bg = "#7ee787", ctermfg = 234, ctermbg = 114, bold = true })
  hl(0, "CmpItemAbbrMatch",      { fg = p.pkg.gui,     ctermfg = p.pkg.cterm,     bold = true })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "CmpItemAbbrDeprecated", { ctermfg = 243,       strikethrough = true })
  hl(0, "CmpItemKindFunction",   { fg = p.func.gui,    ctermfg = p.func.cterm })
  hl(0, "CmpItemKindMethod",     { fg = p.func.gui,    ctermfg = p.func.cterm })
  hl(0, "CmpItemKindField",      { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "CmpItemKindProperty",   { fg = p.field.gui,   ctermfg = p.field.cterm })
  hl(0, "CmpItemKindModule",     { fg = p.pkg.gui,     ctermfg = p.pkg.cterm })
  hl(0, "CmpItemKindClass",      { fg = p.orange.gui,  ctermfg = p.orange.cterm })
  hl(0, "CmpItemKindInterface",  { fg = p.builtin.gui, ctermfg = p.builtin.cterm })
  hl(0, "CmpItemKindKeyword",    { fg = p.keyword.gui, ctermfg = p.keyword.cterm })
  hl(0, "CmpItemKindSnippet",    { fg = p.param.gui,   ctermfg = p.param.cterm })
  hl(0, "CmpItemKindConstant",   { fg = p.yellow.gui,  ctermfg = p.yellow.cterm })
  hl(0, "CmpItemKindEnumMember", { fg = p.yellow.gui,  ctermfg = p.yellow.cterm })
  hl(0, "CmpItemKindVariable",   { ctermfg = 250 })

  -- ── 边栏 ─────────────────────────────────────────────────────
  hl(0, "SignColumn", { bg = "NONE", ctermbg = "NONE" })
  hl(0, "FoldColumn", { bg = "NONE", ctermbg = "NONE" })
  hl(0, "Folded",     { ctermfg = 243, italic = true })
end

return M
