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
  callback = function()
    vim.cmd("source <afile> | PackerSync")
    utils.info("Running PackerSync...", "Packer")
  end,
  group = packGroup
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

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

      if vim.fn.isdirectory(vim.fn.expand("~/Documents/git/projects/" .. plug_path)) == 1 then
        opts[1] = "~/Documents/git/projects/" .. plug_path
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

    use  "moll/vim-bbye"

    use {
      "akinsho/toggleterm.nvim",
      tag = '*',
      config = function()
        require('plugins.configs.toggleterm')
      end,
      cmd = { "ToggleTerm", "TermExec" }
    }

    use {
      "nvim-neo-tree/neo-tree.nvim",
      requires = {
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("plugins.configs.neotree")
      end
    }

    use {
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      event = "BufRead",
      config = function()
        require("plugins.configs.lualine")
      end
    }

    use {
      "akinsho/bufferline.nvim",
      opt = true,
      event = "BufRead",
      config = function()
        require("plugins.configs.bufferline")
      end
    }

    -- use {
    --   "j-hui/fidget.nvim",
    --   config = function()
    --     require("fidget").setup {
    --       text = {
    --         spinner = "star",
    --         done = ""
    --       }
    --     }
    --     vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
    --   end,
    --   after = "nvim-lspconfig"
    -- }

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
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-file-browser.nvim",
      },
      config = function()
        require("ah.telescope")
      end,
    }

    -- use {
    --   "Pocco81/true-zen.nvim",
    --   cmd = { "TZAtaraxis", "TZMinimalist" },
    --   config = function()
    --     require("plugins.configs.zen")
    --   end
    -- }

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("plugins.configs.zen")
      end
    }

    use {
      "ixru/nvim-markdown",
      ft = "markdown"
    }
    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" }
    })
    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages",
        "Verbose"
      }
    }

    -- use {
    --   "karb94/neoscroll.nvim",
    --   config = function ()
    --     require("plugins.configs.neoscroll")
    --   end
    -- }

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
        },
      },
    }

    -- use {
    --   "hrsh7th/cmp-nvim-lsp-signature-help"
    -- }

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
      ft = { "tex", "markdown "}
    }
    use {
      "SirVer/ultisnips",
      after = "nvim-cmp",
    }
    use  "brymer-meneses/grammar-guard.nvim"

    use "nanotee/luv-vimdocs"
    use "milisims/nvim-luaref"

    use {
      "jupyter-vim/jupyter-vim",
      ft = "python"
    }

    -- use {
    --   "folke/noice.nvim",
    --   config = function()
    --     require("plugins.configs.noice")
    --   end,
    --   requires = {
    --     "MunifTanjim/nui.nvim",
    --     {
    --       "smjonas/inc-rename.nvim",
    --       config = function()
    --         require("inc_rename").setup()
    --       end
    --     }
    --   }
    -- }

    use {
      "echasnovski/mini.indentscope",
      event = { "BufReadPre", "BufNewFile" },
      -- config = function()
      --   require("mini.indentscope").setup {
      --     symbol = "│"
      --   }
      -- end
      config = function()
        require("plugins.configs.indent_scope")
      end
    }

    -- colourschemes --

    use "catppuccin/nvim"
    use "embark-theme/vim"
    use 'AlexvZyl/nordic.nvim'
    use 'Mofiqul/vscode.nvim'
    use 'navarasu/onedark.nvim'

    -- use "aymenhafeez/tokyonight.nvim"
    local_use "tokyonight.nvim"

    -- use "aymenhafeez/neodark.nvim"
    local_use "neodark.nvim"

    use "aymenhafeez/OxfDictionary.nvim"
    -- local_use "OxfDictionary.nvim"

    -- use {
    --   "aymenhafeez/scratch.vim",
    --   cmd = {"Scratch", "Sscratch" }
    -- }
    -- local_use "scratch.vim"

    use {
      "aymenhafeez/scratch.nvim",
      config = function()
        require("plugins.configs.scratch")
      end
    }
    -- local_use "scratch.lua"

    -- use "aymenhafeez/vim-line-motion"
    -- local_use "vim-line-motion"

    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
}
