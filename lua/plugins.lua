-- 管理插件
return require('packer').startup({
  function(use)
    -- Packer 自管理
    use 'wbthomason/packer.nvim'

    -- 状态栏
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- fzf 插件
    use {
      'junegunn/fzf',
      run = function() vim.fn['fzf#install']() end
    }
    use {
      'junegunn/fzf.vim',
      config = function() require('pluginconf.fzf') end
    }

    -- NERDTree 文件树
    use {
      'preservim/nerdtree',
      config = function() require('pluginconf.nerdtree') end
    }

    -- Tree-sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function() require('pluginconf.treesitter') end
    }

    -- 主题插件
    use { 
      'morhetz/gruvbox',
      config = function() require('pluginconf.theme') end
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = function() require('pluginconf.lsp') end
    }

    -- Copilot
    use {
      'github/copilot.vim',
      config = function() require('pluginconf.copilot') end
    }

    -- 核心补全引擎
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',     -- LSP 补全源
        'hrsh7th/cmp-buffer',       -- 文本补全源
        'hrsh7th/cmp-path',         -- 路径补全源
      },
      config = function()
        require('pluginconf.cmp')
      end
    }

    use {
      'folke/snacks.nvim',
      priority = 1000,
      lazy = false,
      config = function()
        require('pluginconf.snacks') -- 指向新创建的文件
      end
    }

    -- AI 增强: Claude Code
    use {
      'coder/claudecode.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
      config = function()
        require('pluginconf.cc') -- 指向 lua/pluginconf/cc.lua
      end
    }
  -- 注意：这里是插件列表 function(use) 的结束
  end,

  -- packer 全局配置：它是 startup 传入表的第二个 key，与第一个 key（插件函数）并列
  config = {
    git = {
      timeout = 300,
      default_url_format = 'https://github.com/%s',
    }
  }
})
