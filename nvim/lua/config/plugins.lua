local fn = vim.fn

local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)

    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'rcarriga/nvim-notify'
    use 'moll/vim-bbye'
    use 'aymenhafeez/scratch.vim'
    use 'romainl/vim-cool'
    use {
        'karb94/neoscroll.nvim',
        config = 'require "plugins.neoscroll"'
}
    use {
        "voldikss/vim-floaterm",
        cmd = 'FloatermToggle',
        config = 'require "plugins.floaterm"',
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        event = 'BufWinEnter',
        config = 'require "plugins.nvim-tree"'
    }
    use {
        'akinsho/bufferline.nvim', tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        event = 'BufWinEnter',
        config = 'require "plugins.bufferline"'
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        event = 'BufWinEnter',
        config = 'require "plugins.lualine"'
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        event = 'BufWinEnter',
        config = 'require "plugins.treesitter"'
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use { 'lewis6991/impatient.nvim',
        config = function()
            require('impatient')
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use({
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup({
            })
        end
    })
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function() require('nvim-autopairs').setup {} end,
        after = 'nvim-cmp'
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        config = 'require "plugins.telescope"',
        cmd = 'Telescope'
    }

    -- use {
    --     "glepnir/lspsaga.nvim",
    --     branch = "main",
    --     config = 'require "plugins.lspsaga"'
    -- }
    use {
        'neovim/nvim-lspconfig',
        config = 'require "config.lsp"'
    }
    use {
        'williamboman/nvim-lsp-installer',
        config = 'require "config.lsp"'
    }

    use {
        'hrsh7th/nvim-cmp',
        config = 'require "config.cmp"',
        after = 'nvim-lspconfig'
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp'
    }
    use {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp'
    }
    use {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp'
    }
    use {
        'hrsh7th/cmp-cmdline',
        after = 'nvim-cmp'
    }
    use {
        'dmitmel/cmp-cmdline-history',
        after = 'nvim-cmp'
    }
    use {
        'hrsh7th/cmp-nvim-lua',
        after = 'nvim-cmp'
    }
    use {
        'quangnguyen30192/cmp-nvim-ultisnips',
        after = 'nvim-cmp'
    }
    use {
        'SirVer/ultisnips',
        config = 'require "plugins.ultisnips"',
        after = 'nvim-cmp'
    }
    use {
        "kdheepak/cmp-latex-symbols",
        after = 'nvim-cmp'
    }

    use 'navarasu/onedark.nvim'
    use 'aymenhafeez/neodark.nvim'
    use 'folke/tokyonight.nvim'

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
