-- ~/.config/nvim/lua/plugins.lua
return {
  -- 状态栏 (requires 变为 dependencies)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },

  -- NERDTree 文件树
  {
    'preservim/nerdtree',
    config = function() require('pluginconf.nerdtree') end
  },

  -- Tree-sitter (run 变为 build)
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function() require('pluginconf.treesitter') end
  },

  -- 主题插件 (增加 priority 确保优先加载)
  { 
    'morhetz/gruvbox', 
    priority = 1000,
    config = function() require('pluginconf.theme') end 
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function() require('pluginconf.lsp') end
  },

  -- Copilot
  {
    'github/copilot.vim',
    config = function() require('pluginconf.copilot') end
  },

  -- 核心补全引擎 (requires 变为 dependencies)
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      require('pluginconf.cmp')
    end
  },

  {
    "folke/snacks.nvim",
    -- 这里的 config 会自动寻找并执行 lua/pluginconf/snacks.lua
    config = function() require("pluginconf.snacks") end,
  }
}

