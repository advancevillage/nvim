-- ~/.config/nvim/lua/pluginconf/claudecode.lua
-- Claude Code Neovim 集成（coder/claudecode.nvim）
local ok, claudecode = pcall(require, "claudecode")
if not ok then return end
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= false
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end
-- 核心控制
map("n", "<Leader>ac", "<cmd>ClaudeCode<CR>",          { desc = "Toggle Claude" })
map("n", "<Leader>af", "<cmd>ClaudeCodeFocus<CR>",     { desc = "Focus Claude" })
-- 插件配置
claudecode.setup({
  auto_start = true,
  -- 终端配置：使用 snacks 作为 provider，并自定义窗口
  terminal = {
    split_side = "right",                  -- 或 "bottom" / "left"
    split_width_percentage = 0.30,         -- 右侧 30% 宽度
    provider = "snacks",                   -- 明确用 snacks（或 "auto" 也行）
    auto_close = true,
    provider_opts = {
      external_terminal_cmd = nil,
    },
    snacks_win_opts = {
      position = "bottom",                 -- 底部停靠
      height  = 0.40,                      -- 高度 40%
      border  = "rounded",                 -- 圆角边框
      title   = "Claude Code",             -- 窗口标题
      title_pos = "center",
    },
  },
})
