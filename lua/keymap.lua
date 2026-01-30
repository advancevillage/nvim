-- ~/.config/nvim/lua/keymap.lua
-- Neovim Lua 键映射配置 (迁移自 Vim keymap.vim)

--========================
----> Leader 键
--========================
vim.g.mapleader = ";"   -- 设置 Leader
vim.g.maplocalleader = ";"

--========================
----> 插入模式快捷键
--========================
-- 重映射 <Esc>
vim.keymap.set("i", "<leader>;", "<Esc>", { noremap = true, silent = true })

--========================
----> 正常模式快捷键 (nmap/noremap)
--========================
local opts = { noremap = true, silent = true }

-- 文件操作
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
vim.keymap.set("n", "<leader>w", ":w!<CR>", opts)
vim.keymap.set("n", "<leader>Q", ":qa<CR>", opts)
vim.keymap.set("n", "<leader>W", ":wq<CR>", opts)
vim.keymap.set("n", "<leader>d", ":cq<CR>", opts)

-- 十六进制转换
vim.keymap.set("n", "<leader>x", ":%!xxd<CR>", opts)
vim.keymap.set("n", "<leader>xx", ":%!xxd -r<CR>", opts)

-- 文件行倒序
vim.keymap.set("n", "<leader>r", ":g/^/m0<CR>", opts)

-- 窗口切换
vim.keymap.set("n", "<leader>lw", "<C-W>l", opts)
vim.keymap.set("n", "<leader>hw", "<C-W>h", opts)
vim.keymap.set("n", "<leader>jw", "<C-W>j", opts)
vim.keymap.set("n", "<leader>kw", "<C-W>k", opts)

-- buffer 切换
vim.keymap.set("n", "<leader><tab>", ":bn<CR>", opts)
vim.keymap.set("n", "<leader><tab><tab>", ":bp<CR>", opts)

-- tab 操作
vim.keymap.set("n", "<leader>tn", ":tabnew<Space><Space><Space>", opts)
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", opts)

-- 分屏操作
vim.keymap.set("n", "<leader>sp", ":split<CR>", opts)
vim.keymap.set("n", "<leader>vsp", ":vsplit<CR>", opts)
vim.keymap.set("n", "<leader>cl", ":close<CR>", opts)

-- 翻页 (Ctrl-F / Ctrl-B)
vim.keymap.set("n", "nn", "<C-F>", opts)
vim.keymap.set("n", "uu", "<C-B>", opts)
