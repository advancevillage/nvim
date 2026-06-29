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
      position = "float",                  -- 浮窗
      width   = 0.85,                      -- 宽度 85%
      height  = 0.70,                      -- 高度 65%
      border  = "rounded",                 -- 圆角边框
      title   = "Claude Code",             -- 窗口标题
      title_pos = "center",
      -- 仅作用于 Claude 浮窗的 buffer-local 快捷键
      keys = {
        -- 终端模式下按 <C-q> 隐藏浮窗（走 :ClaudeCode，只隐藏不退出，输入保留）
        claude_hide = {
          "<C-h>",
          function() vim.cmd("ClaudeCode") end,
          mode = "t",
          desc = "Hide Claude",
        },
      },
    },
  },
})

-- 让鼠标滚轮能在 Claude 浮窗中滑动历史：
-- 全局保持 mouse=r，仅在聚焦 Claude 终端时临时切到 mouse=a，离开即恢复。
local mouse_grp = vim.api.nvim_create_augroup("ClaudeCodeMouse", { clear = true })
local saved_mouse = nil

local function is_claude_term(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return false end
  if vim.bo[buf].filetype ~= "snacks_terminal" then return false end
  local info = vim.b[buf].snacks_terminal
  return info ~= nil and type(info.cmd) == "string" and info.cmd:lower():find("claude") ~= nil
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  group = mouse_grp,
  callback = function(args)
    if is_claude_term(args.buf) then
      if saved_mouse == nil then saved_mouse = vim.o.mouse end
      vim.o.mouse = "a"
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "TermClose" }, {
  group = mouse_grp,
  callback = function(args)
    if saved_mouse ~= nil and is_claude_term(args.buf) then
      vim.o.mouse = saved_mouse
      saved_mouse = nil
    end
  end,
})
