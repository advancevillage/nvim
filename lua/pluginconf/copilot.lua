-- 1. 这里设置为默认关闭 (* = false)，仅在 go 和 python 中开启
vim.g.copilot_filetypes = {
    ["*"] = false,
    ["go"] = true,
}

-- 2. 禁用默认的 Tab 键映射，防止冲突
vim.g.copilot_no_tab_map = true

-- 3. 设置快捷键 <C-j> (Ctrl + j) 接受建议
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false,
    silent = true
})
