-- fzf.vim 全局变量配置
vim.g.fzf_vim = vim.g.fzf_vim or {}
vim.g.fzf_vim.preview_window = { 'right,50%', 'ctrl-/' }

-- 快捷键映射
vim.api.nvim_set_keymap('n', '<Leader>f', ':Files<CR>', { noremap = true, silent = true })
