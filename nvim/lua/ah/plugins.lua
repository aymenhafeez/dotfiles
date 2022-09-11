local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
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

local packGroup = vim.api.nvim_create_augroup("PackWriteSync", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*plugins.lua",
  command = "source <afile> | PackerSync",
  group = packGroup
})

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

return packer.startup {
  function(use)
    local local_use = function(first, second, opts)
      opts = opts or {}

      local plug_path, home
      if second == nil then
        plug_path = first
        home = "aymen"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/Documents/projects/" .. plug_path)) == 1 then
        opts[1] = "~/Documents/projects/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    use {
      "wbthomason/packer.nvim",
      opt = true
    }
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"

    use {
      "rcarriga/nvim-notify",
      event = "BufRead",
      config = function()
        require("plugins.notify")
      end
    }

    use "moll/vim-bbye"
    use "romainl/vim-cool"

    use {
      "karb94/neoscroll.nvim",
      event =  "BufEnter",
      config = function()
        require("plugins.neoscroll")
      end
    }
    use {
      "voldikss/vim-floaterm",
      cmd = { "FloatermToggle", "FloatermNew" },
      config = function()
        require("plugins.floaterm")
      end
    }
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeOpen" },
      config = function()
        require("plugins.nvim-tree")
      end
    }
    use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      event = "BufEnter",
      config = function()
        require("plugins.bufferline")
      end
    }
    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      event = "BufEnter",
      config = function()
        require("plugins.lualine")
      end
    }
    use {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup {
          text = {
            spinner = "circle_halves",
            done = ""
          }
        }
      end
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground"
      },
      event = { "BufRead", "BufWinEnter", "BufNewFile" },
      run = ":TSUpdate",
      cmd = {
        "TSInstall",
        "TSBufEnable",
        "TSBufDisable",
        "TSEnable",
        "TSDisable",
        "TSModuleInfo",
      },
      config = function()
        require("plugins.treesitter")
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("gitsigns").setup()
      end
    }
    use {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient")
      end
    }
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gb" },
      config = function()
        require("Comment").setup()
      end,
    }
    use({
      "kylechui/nvim-surround",
      event = "BufEnter",
      config = function()
        require("nvim-surround").setup()
      end,
    })
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup()
      end,
      after = "nvim-cmp"
    }

    use {
      "nvim-telescope/telescope.nvim" ,
      requires = {
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        -- "nvim-telescope/telescope-packer.nvim",
        "crispgm/telescope-heading.nvim",
        "jvgrootveld/telescope-zoxide",
      },
      config = function()
        require("ah.telescope")
      end,
    }

    use {
      "Pocco81/true-zen.nvim",
      cmd = { "TZAtaraxis", "TZMinimalist" },
      config = function()
        require("plugins.zen")
      end
    }

    use {
      "ixru/nvim-markdown",
      ft = "markdown"
    }

    -- lsp stuff --

    use {
      "williamboman/nvim-lsp-installer",
      events = { "BufRead", "BufWinEnter", "BufNewFile" },
      config = function()
        require("ah.lsp")
      end,
    }
    use {
      "neovim/nvim-lspconfig",
      events = { "BufRead", "BufWinEnter", "BufNewFile" },
      config = function()
        require("ah.lsp")
      end,
      requires = {
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("plugins.navic")
          end,
          module = { "nvim-navic" },
        }
      },
    }

    -- cmp --

    use {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      config = function()
        require("plugins.cmp")
      end,
      after = "nvim-lspconfig"
    }
    use {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-path",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-cmdline",
      after = "nvim-cmp"
    }
    use {
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp"
    }
    use {
      "quangnguyen30192/cmp-nvim-ultisnips",
      after = "nvim-cmp"
    }
    use {
      "kdheepak/cmp-latex-symbols",
      event = "InsertEnter",
      after = "nvim-cmp"
    }
    use {
      "SirVer/ultisnips",
      event = "InsertEnter",
      after = "nvim-cmp"
    }
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "brymer-meneses/grammar-guard.nvim"

    use "dstein64/vim-startuptime"

    -- colorschemes --

    use "navarasu/onedark.nvim"
    use "folke/tokyonight.nvim"
    use "Mofiqul/vscode.nvim"
    use "catppuccin/nvim"

    use "aymenhafeez/neodark.nvim"
    -- local_use "neodark.nvim"

    use "aymenhafeez/OxfDictionary.nvim"
    -- local_use "OxfDictionary"

    use "aymenhafeez/scratch.vim"
    -- local_use "scratch.vim"

    -- use "aymenhafeez/vim-line-motion"
    local_use "vim-line-motion"

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end}
