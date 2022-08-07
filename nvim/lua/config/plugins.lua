local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
  augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)

    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "SirVer/ultisnips"
    use "nvim-lua/plenary.nvim"
    use "kyazdani42/nvim-tree.lua"
    use "kyazdani42/nvim-web-devicons"
    use "rcarriga/nvim-notify"
    use "karb94/neoscroll.nvim"
    use "moll/vim-bbye"
    use "voldikss/vim-floaterm"
    use "romainl/vim-cool"
    use {'akinsho/bufferline.nvim', tag = "v2.*"}
    use "nvim-lualine/lualine.nvim"
    use "Pocco81/true-zen.nvim"
    use 'aymenhafeez/scratch.vim'
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "nvim-treesitter/playground"
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
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
            })
        end
    })
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "quangnguyen30192/cmp-nvim-ultisnips"
    use "kdheepak/cmp-latex-symbols"
    -- use "brymer-meneses/grammar-guard.nvim"

    use "navarasu/onedark.nvim"
    use "VDuchauffour/neodark.nvim"
    use 'folke/tokyonight.nvim'

  if PACKER_BOOTSTRAP then
      require("packer").sync()
  end
end)

