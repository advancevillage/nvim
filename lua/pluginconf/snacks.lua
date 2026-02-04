-- ~/.config/nvim/lua/pluginconf/snacks.lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end

snacks.setup({
  -- 1. Picker 配置 (类似 fzf)
  picker = {
    enabled = true,
    ui_select = true,       -- 取代原生 vim.ui.select
    layout = "center",      -- 浮窗居中显示
    prompt = "🔍 Search: ", -- 提示符
  },

  -- 2. 终端配置 (Claude Code 等使用)
  terminal = {
    enabled = true,
    win = {
      style = "terminal",
      position = "float",
      border = "rounded",
      size = { width = 0.8, height = 0.5 }, -- 宽高百分比
    },
  },

  -- 3. 通知配置
  notifier = {
    enabled = true,
    timeout = 3000,        -- 单位毫秒
    level = "info",        -- 过滤通知等级
  },

  -- 4. 样式修正：彻底解决 E1512 报错
  styles = {
    notification = {
      wo = {
        list = false,
        winbar = "",                 -- 禁用 winbar 防止宽度计算错误
        fillchars = "lastline: ",
        listchars = "extends: ,precedes: ",
      },
      border = "rounded",            -- 统一边框样式
    },
    terminal = {
      wo = {
        list = false,
        winbar = "",
        fillchars = "lastline: ",
        listchars = "extends: ,precedes: ",
      },
      border = "rounded",
    },
  },

  -- 5. 其他实用功能
  dashboard = { enabled = true }, 
  indent = { 
    enabled = true, 
    color = "#7c6f64",             -- 缩进线颜色，柔和灰
  },
  scroll = { enabled = false },     -- v0.11 建议关闭防止卡顿
})

-- 快捷键绑定逻辑
local map = vim.keymap.set

-- 文件搜索 (类似 fzf :Files)
map("n", "<Leader>f", function() snacks.picker.files() end, { desc = "Find Files" })

-- 全局搜索文本 (类似 fzf :Ag / :Rg)
map("n", "<Leader>a", function() snacks.picker.grep() end, { desc = "Grep" })
