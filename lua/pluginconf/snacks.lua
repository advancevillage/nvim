-- lua/pluginconf/snacks.lua
local ok, snacks = pcall(require, "snacks")
if not ok then return end

snacks.setup({
  terminal = {
    enabled = true,
    win = {
      style = "terminal",
      position = "float",
      border = "rounded",
      wo = {
        list = false,
        -- 核心修复：即使 list=false，v0.11 有时仍会检查这些字段
        -- 强制将它们设置为空，防止宽度校验 (E1512)
        fillchars = "lastline: ", 
        listchars = "extends: ,precedes: ",
        winhighlight = "Normal:SnacksTerminalNormal,FloatBorder:SnacksTerminalBorder",
      }
    }
  },
  scroll = { enabled = false },
  notifier = { enabled = true },
  indent = { enabled = true },
})

