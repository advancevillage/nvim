local ok, snacks = pcall(require, "snacks")
if not ok then return end

snacks.setup({
  -- ========== 1. Picker（文件搜索 / Grep，类似 fzf） ==========
  picker = {
    enabled = true,
    ui_select = true,         -- 接管 vim.ui.select
    prompt = "Search: ",
    layout = {
      preset = "default",    -- 关键：必须是能生成 root box 的 preset
      cycle = false,
    },
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },

  -- ========== 2. Terminal（Claude Code / 浮动终端） ==========
  terminal = {
    enabled = true,
    win = {
      style = "terminal",
      position = "float",
      border = "rounded",
      size = { width = 0.8, height = 0.5 },
    },
  },

  -- ========== 3. 通知 ==========
  notifier = {
    enabled = true,
    timeout = 3000,
    level = "info",
    style = "compact",
  },

  -- ========== 4. 样式（不设 listchars，彻底规避 E1512） ==========
  styles = {
    notification = {
      wo = {
        list = false,
        winbar = "",
      },
      border = "rounded",
    },
    picker = {
      wo = {
        winbar = "",
      },
    },
    terminal = {
      wo = {
        list = false,
        winbar = "",
      },
      border = "rounded",
    },
  },

  -- ========== 5. 其他功能 ==========
  dashboard = { enabled = true },

  indent = {
    enabled = true,
    char = "│",
    color = "#7c6f64",
  },

  scroll = {
    enabled = false, -- 避免 0.11+ 偶发卡顿
  },
})

-- ========== 快捷键 ==========
local map = vim.keymap.set

-- 文件搜索 (类似 fzf :Files)
map("n", "<Leader>f", function() snacks.picker.files() end, { desc = "Files" })

-- 全局搜索文本 (类似 fzf :Ag / :Rg)
map("n", "<Leader>a", function() snacks.picker.grep() end, { desc = "Grep" })

-- 折叠
map("n", "<Leader>z", "za", { desc = "Fold"})
