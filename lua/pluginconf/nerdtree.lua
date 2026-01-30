-- 全局变量配置
vim.g.NERDTreeDirArrowExpandable = '▸'  -- 可展开目录的图标
vim.g.NERDTreeDirArrowCollapsible = '▾' -- 可折叠目录的图标
vim.g.NERDTreeWinPos = "left"           -- 文件树位置
vim.g.NERDTreeShowHidden = 0             -- 是否显示隐藏文件
vim.g.NERDTreeAutoDeleteBuffer = 1       -- 自动清除缓存

-- 快捷键 <Leader>ft 打开/关闭 NERDTree
vim.api.nvim_set_keymap('n', '<Leader>ft', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 自动打开 NERDTree（VimEnter）
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NERDTree")
    end
})

-- 自动关闭 NERDTree 窗口，如果它是最后一个窗口
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local winnr = vim.fn.winnr("$")
        local b = vim.b
        if winnr == 1 and b.NERDTree and b.NERDTree.isTabTree then
            vim.cmd("q")
        end
    end
})
