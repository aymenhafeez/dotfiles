local fn = vim.fn
local utils = require("ah.utils")

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
  pattern = "*plugins/init.lua",
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

    use "nvim-lua/plenary.nvim"
    use {
      "lewis6991/impatient.nvim",
      config = function()
        require("impatient").enable_profile()
      end
    }

    use {
      "wbthomason/packer.nvim",
      opt = true,
      cmd = utils.packer_cmds
    }
    use "nvim-lua/popup.nvim"

    use {
      "rcarriga/nvim-notify",
      event = "BufRead",
      config = function()
        require("plugins.configs.notify")
      end
    }

    use "moll/vim-bbye"

    use {
      "karb94/neoscroll.nvim",
      event = "BufEnter",
      config = function()
        require("plugins.configs.neoscroll")
      end
    }
    use {
      "voldikss/vim-floaterm",
      cmd = { "FloatermToggle", "FloatermNew" },
      config = function()
        require("plugins.configs.floaterm")
      end
    }
    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeOpen" },
      config = function()
        require("plugins.configs.nvim-tree")
      end
    }
    use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      event = "UIEnter",
      config = function()
        require("plugins.configs.bufferline")
      end
    }
    use {
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      event = "UIEnter",
      config = function()
        require("plugins.configs.lualine")
      end
    }
    use {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup {
          text = {
            spinner = "arc",
            done = ""
          }
        }
        vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
      end,
      after = "nvim-lspconfig"
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
          "nvim-treesitter/playground",
          cmd = { "TSPlayground", "TSHighlightCapturesUnderCursor" }
        }
      },
      event = { "BufRead", "BufWinEnter", "BufNewFile" },
      run = ":TSUpdate",
      config = function()
        require("plugins.configs.treesitter")
      end
    }
    if packer_plugins and packer_plugins["nvim-treesitter"] then
      vim.cmd("PackerLoad nvim-treesitter")
    end

    use {
      "lewis6991/gitsigns.nvim",
      ft = "gitcommit",
      event = "BufRead",
      config = function()
        require("gitsigns").setup()
      end
    }
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gb" },
      config = function()
        require("Comment").setup()
      end,
    }
    use {
      "kylechui/nvim-surround",
      event = "BufReadPre",
      config = function()
        require("nvim-surround").setup()
      end,
    }
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup()
      end,
      after = "nvim-cmp"
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        -- { "crispgm/telescope-heading.nvim", cmd = "Telescope" },
        -- { "nvim-telescope/telescope-packer.nvim", cmd = "Telescope"},
        -- { "jvgrootveld/telescope-zoxide", cmd = "Telescope" }
      },
      config = function()
        require("ah.telescope")
      end,
    }

    use {
      "Pocco81/true-zen.nvim",
      cmd = { "TZAtaraxis", "TZMinimalist" },
      config = function()
        require("plugins.configs.zen")
      end
    }

    use {
      "ixru/nvim-markdown",
      ft = "markdown"
    }

    -- lsp stuff --

    use {
      "williamboman/nvim-lsp-installer",
      event = "BufRead",
    }
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      after = "nvim-lsp-installer",
      config = function()
        require("ah.lsp")
      end,
      requires = {
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("plugins.configs.navic")
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
        require("plugins.configs.cmp")
      end,
      after = "nvim-lspconfig"
    }
    use {
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-cmp"
    }
    use {"folke/lua-dev.nvim",
      config = function()
        require("lua-dev").setup()
      end
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
      "quangnguyen30192/cmp-nvim-ultisnips",
      after = "nvim-cmp",
      ft = { "tex", "md "}
    }
    use {
      "SirVer/ultisnips",
      after = "nvim-cmp",
    }
    use {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      after = "nvim-cmp"
    }
    use "brymer-meneses/grammar-guard.nvim"

    use "nanotee/luv-vimdocs"
    use "milisims/nvim-luaref"

    -- colorschemes --

    use {
      "uga-rosa/ccc.nvim",
      cmd = "CccPick"
    }

    use "navarasu/onedark.nvim"
    use "folke/tokyonight.nvim"
    use "Mofiqul/vscode.nvim"
    use "catppuccin/nvim"

    -- use "aymenhafeez/neodark.nvim"
    local_use "neodark.nvim"

    use "aymenhafeez/OxfDictionary.nvim"
    -- local_use "OxfDictionary"

    -- use "aymenhafeez/scratch.vim"
    local_use "scratch.vim"

    -- use "aymenhafeez/vim-line-motion"
    -- local_use "vim-line-motion"

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end
}
