local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'vimwiki/vimwiki'
  use 'wbthomason/packer.nvim'
  use 'alec-gibson/nvim-tetris'
  use 'soywod/iris.vim'
  use 'jim-fx/sudoku.nvim'
  use {'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use 'sharkdp/fd'
  use 'EdenEast/nightfox.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'williamboman/mason.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use ({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
      },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
      })

  use {
    "delphinus/auto-cursorline.nvim",
    config = function()
      require("auto-cursorline").setup {}
    end,
      }

  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use {
        'williamboman/mason-lspconfig.nvim',
   }
  use {
        'hrsh7th/nvim-cmp',
    }

  use {
        'hrsh7th/cmp-nvim-lsp',
    }

  use {
        'L3MON4D3/LuaSnip',
        requires = {
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
        },
    }

  use {
        'dcampos/nvim-snippy',
    }

  use {
        'dcampos/cmp-snippy',
    }

  use {
        'onsails/lspkind.nvim',
    }
  use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
    }
--  use 'luukvbaal/statuscol.nvim'
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
