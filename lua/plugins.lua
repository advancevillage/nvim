-- 管理插件
return require('packer').startup(function(use)
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
      run = function() vim.fn['fzf#install']() end -- 安装 fzf 二进制
    }
    use {
      'junegunn/fzf.vim',
      config = function()
        require('pluginconf.fzf')  -- 加载 fzf.lua 配置
      end
    }
    -- NERDTree 文件树
    use {
      'preservim/nerdtree',
      config = function()
        require('pluginconf.nerdtree')  -- 加载单独配置
      end
    }
    -- 主题
    use {"catppuccin/nvim", as = "catppuccin" }


    -- LSP 配置插件
    use {
      'neovim/nvim-lspconfig',
      config = function()
        require('pluginconf.lsp')
      end
    }

    use {
      'github/copilot.vim',
       config = function()
        require('pluginconf.copilot')
      end
    }

end)
