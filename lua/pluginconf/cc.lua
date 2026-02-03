local ok, claudecode = pcall(require, "claudecode")
if not ok then return end

claudecode.setup({
  -- 重点：必须是 table
  terminal = {
    provider = "snacks",
  },
  
  -- 其它功能
  auto_save = true,
  
  window = {
    position = "float",
    size = { width = 0.8, height = 0.8 },
    border = "rounded",
  },
})

-- 快捷键
vim.keymap.set("n", "<Leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Claude AI", silent = true })
