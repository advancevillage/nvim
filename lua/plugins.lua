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
      run = function()
        vim.fn['fzf#install']()
      end
    }

    use {
      'junegunn/fzf.vim',
      config = function()
        require('pluginconf.fzf')
      end
    }

    -- NERDTree 文件树
    use {
      'preservim/nerdtree',
      config = function()
        require('pluginconf.nerdtree')
      end
    }

    -- Tree-sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function()
        require('pluginconf.treesitter')
      end
    }

    -- 主题插件
    use {
      'navarasu/onedark.nvim',
      config = function()
        require('pluginconf.theme')
      end
    }

    -- LSP
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('pluginconf.lsp')
      end
    }

    -- Copilot
    use {
      'github/copilot.vim',
      config = function()
        require('pluginconf.copilot')
      end
    }
  end,

  -- packer 全局配置
  config = {
    git = {
      timeout = 300,
      default_url_format = 'https://github.com/%s',
    }
  }
})
