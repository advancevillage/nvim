-- ================================================================
--  theme.lua
--  路径: ~/.config/nvim/lua/pluginconf/theme.lua
-- ================================================================

-- ── 1. 基础环境
vim.opt.termguicolors = false
vim.opt.background    = "dark"
vim.highlight.priorities.semantic_tokens = 95
vim.highlight.priorities.treesitter      = 50

-- ── 2. Gruvbox（morhetz/gruvbox 是 vimscript 插件，用 vim.g.* 配置）
vim.g.gruvbox_contrast_dark    = "hard"
vim.g.gruvbox_italic           = 1
vim.g.gruvbox_termcolors       = 256
vim.g.gruvbox_invert_selection = 0

vim.cmd("colorscheme gruvbox")
vim.cmd("syntax on")

-- ── 3. 应用 Go 语义高亮
--    vim.schedule 保证在 colorscheme 事件全部触发后再覆盖，
--    否则 gruvbox 的 after/colors 脚本会把自定义高亮冲掉
vim.schedule(function()
  require("pluginconf.nightowl").apply()
end)
