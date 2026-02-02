-- 关掉真彩色，适配 Terminal.app
vim.opt.termguicolors = false

local ok, onedark = pcall(require, "onedark")
if not ok then return end

onedark.setup({
  style = 'dark',
  -- 重点：在 256 色环境下，禁用所有复杂的 Treesitter 插件支持
  plugins = {
    ["nvim-treesitter"] = false, 
    ["nvim-lspconfig"] = false,
  },
})

-- 强行加载
vim.cmd("colorscheme onedark")

-- 补丁：如果还是蓝屏，强行重置 Normal 背景
vim.cmd([[
  hi Normal ctermbg=NONE
  hi NonText ctermbg=NONE
]])
