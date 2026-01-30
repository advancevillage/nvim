local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then return end

treesitter.setup({
  -- 1. 确保安装了 Go 相关的解析器
  ensure_installed = { 
    "go", 
    "gomod", 
    "gosum", 
    "gowork",
    "lua",      -- 顺便把 lua 也装了，方便配 nvim
    "markdown",
    "vimdoc"
  },

  -- 2. 启用高亮
  highlight = {
    enable = true,              -- 开启高亮
    additional_vim_regex_highlighting = false, -- 禁用基础正则，让高亮更精准
  },

  -- 3. 启用增量选择（写 Go 时非常有用，可以快速选中一个函数块）
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },

  -- 4. 启用缩进
  indent = {
    enable = true
  }
})
