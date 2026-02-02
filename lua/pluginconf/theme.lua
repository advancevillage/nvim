-- lua/pluginconf/theme.lua
vim.opt.termguicolors = true
vim.opt.background = "dark"

local ok, onedark = pcall(require, "onedark")
if not ok then return end

onedark.setup({
  style = "dark",

  code_style = {
    comments  = "italic",
    keywords  = "none",
    functions = "bold",
    strings   = "none",
    variables = "none",
  },

  plugins = {
    ["nvim-treesitter"] = true,
    ["nvim-lspconfig"] = true,
  },

  highlights = {
    -- 类型
    ["@type"]         = { fg = "#e5c07b", fmt = "bold" }, -- 黄色
    ["@type.builtin"] = { fg = "#e06c75" },               -- 红色

    -- 函数 / 方法（只加粗，不改颜色）
    ["@function"] = { fmt = "bold" },
    ["@method"]   = { fmt = "bold" },

    -- 参数（含 receiver）
    ["@parameter"] = { fg = "#abb2bf", fmt = "italic" }, -- 浅灰

    -- 变量
    ["@variable"] = { fg = "#abb2bf" },

    -- 控制流
    ["@conditional"] = { fg = "#c678dd" },
    ["@repeat"]      = { fg = "#c678dd" },

    -- 字面量
    ["@string"]  = { fg = "#98c379" },
    ["@number"]  = { fg = "#d19a66" },
    ["@boolean"] = { fg = "#d19a66" },

    -- 注释
    ["@comment"] = { fg = "#5c6370", fmt = "italic" },

    -- 运算符 / 标点
    ["@operator"]              = { fg = "#abb2bf" },
    ["@punctuation.delimiter"] = { fg = "#5c6370" },
    ["@punctuation.bracket"]   = { fg = "#5c6370" },
  },
})

onedark.load()
