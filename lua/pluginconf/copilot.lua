-- ~/.config/nvim/lua/pluginconf/copilot.lua
require("copilot").setup({
  -- 关闭 Copilot 自带的虚拟文本提示，避免和 nvim-cmp 重复
  -- 如果你不用 cmp、想要"幽灵文本"那种行内提示，把 enabled 改回 true
  suggestion = {
    enabled = false,
    auto_trigger = false,
    keymap = {
      accept = "<Tab>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  -- 关闭 panel 模式（用 cmp 集成更现代）
  panel = {
    enabled = false,
  },
  -- 文件类型白名单：默认全关，仅在指定语言开启
  filetypes = {
    ["*"] = false,
    go = true,
    markdown = true,
    -- 想加其他语言就在这里加，比如：
    -- python = true,
    -- lua = true,
    -- javascript = true,
    -- typescript = true,
  },
})
