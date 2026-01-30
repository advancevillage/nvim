local status_t, tokyonight = pcall(require, "tokyonight")
if not status_t then return end

-- 1. 先获取颜色对象 (必须传入风格，确保 c.bg_dark 等变量存在)
local colors = require("tokyonight.colors").setup({ style = "night" })
local util = require("tokyonight.util")

-- 2. 统一调用 setup，只写一次
tokyonight.setup({
  style = "day",
  transparent = false,
  terminal_colors = true,
  
  -- 样式微调
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {}, -- 禁用函数斜体
    variables = {},
  },

  -- 修改特定颜色（变量级别）
  on_colors = function(c)
    c.hint = c.orange
    c.error = "#ff0000" -- 亮红色
  end,

  -- 修改高亮组（UI 插件级别）
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    
    -- 优化 Telescope 外观，使其更有层次感
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = { bg = prompt }
    hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
    hl.TelescopePromptTitle = { bg = prompt, fg = prompt }
    hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
    hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
    
    -- 修复可能的错误：确保关键字和注释符合预期
    hl.Keyword = { italic = true, fg = c.magenta }
  end,
})

-- 3. 激活主题
vim.opt.termguicolors = true
vim.cmd([[colorscheme tokyonight-day]])

-- 4. Airline 适配
vim.g.airline_theme = 'tokyonight'
