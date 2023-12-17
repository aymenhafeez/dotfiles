local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local present, lazy = pcall(require, "lazy")
if not present then
  return
end

local options = {
  ui = {
    -- border = "rounded",
    border = "none",
    size = {
      width = 0.8,
      height = 0.8
    },
  }
}

-- -- loading local plugins with packer - not needed with lazy.nvim
-- local local_use = function(first, second, opts)
--   opts = opts or {}
--
--   local plug_path, home
--   if second == nil then
--     plug_path = first
--     home = "aymen"
--   else
--     plug_path = second
--     home = first
--   end
--
--   if vim.fn.isdirectory(vim.fn.expand("~/Documents/git/projects/" .. plug_path)) == 1 then
--     opts[1] = "~/Documents/git/projects/" .. plug_path
--   else
--     opts[1] = string.format("%s/%s", home, plug_path)
--   end
--
--   opts
-- end

lazy.setup({
  {
    "nvim-lua/plenary.nvim"
  },

  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end
  },

  {
    "nvim-lua/popup.nvim"
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.noice")
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          require("plugins.configs.notify")
        end
      },
    }
  },

  {
    "moll/vim-bbye"
  },

  {
    "akinsho/toggleterm.nvim",
    -- tag = "*",
    config = function()
      require("plugins.configs.toggleterm")
    end,
    cmd = { "ToggleTerm", "TermExec" }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function()
      require("plugins.configs.neotree")
    end
  },

  { "kyazdani42/nvim-web-devicons" },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = {
  --     "kyazdani42/nvim-web-devicons"
  --   },
  --   config = function()
  --     require("plugins.configs.lualine_3")
  --   end
  -- },

  {
  "akinsho/bufferline.nvim",
    config = function()
      require("plugins.configs.bufferline")
    end
  },

  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require("plugins.configs.indent_scope")
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
    dependencies = {
      {"nvim-treesitter/nvim-treesitter-textobjects"},
      -- {
      --   "nvim-treesitter/nvim-treesitter-context",
      --   config = function()
      --     require("plugins.configs.context")
      --   end
      -- },
      {
        "nvim-treesitter/playground",
        cmd = { "TSPlayground", "TSHighlightCapturesUnderCursor" }
      }
    }
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("plugins.configs.scrollbar")
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      -- require("scrollbar.handlers.gitsigns").setup()
    end
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
    },
    config = function()
      require("ah.telescope")
    end,
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("plugins.configs.zen")
    end
  },

  {
    "ixru/nvim-markdown",
    ft = "markdown"
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" }
  },

  {
    "tpope/vim-scriptease",
    cmd = {
      "Messages",
      "Verbose"
    }
  },

  {
    "jbyuki/nabla.nvim"
  },

  {
    "aymenhafeez/OxfDictionary.nvim"
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      window = {
        -- border = "rounded",
        border = "none",
        winblend = 0
      },
    }
  },

  -- lsp

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("ah.lsp")
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  {
    'Bekaboo/dropbar.nvim',
    config = function()
      require("plugins.configs.dropbar")
    end,
  },

  -- cmp

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("plugins.configs.cmp")
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "quangnguyen30192/cmp-nvim-ultisnips" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" }
    }
  },

  {
    "SirVer/ultisnips"
  },

  {
    "nanotee/luv-vimdocs"
  },

  {
    "milisims/nvim-luaref"
  },

  -- {
  --   "jupyter-vim/jupyter-vim",
  --   ft = "python"
  -- },

  -- {
  --   "goolord/alpha-nvim",
  --   config = function()
  --     require("plugins.configs.alpha")
  --   end
  -- },

  -- colourschemes

  {
    "sainnhe/everforest",
    -- config = function()
    --   vim.g.everforest_better_performance = true
    --   vim.g.everforest_background = "hard"
    --   vim.o.termguicolors = true
    --   vim.cmd.colorscheme("everforest")
    -- end
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },

  {
    "loctvl842/monokai-pro.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("plugins.configs.monokai")
    --   vim.cmd.colorscheme("monokai-pro-spectrum")
    -- end
  },

  {
    'aymenhafeez/nvim-base16',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("base16-colorscheme").with_config({
    --     telescope = false,
    --     cmp = false,
    --   })
    --   vim.cmd.colorscheme("base16-tomorrow-night")
    -- end
  },

  {
    "rose-pine/neovim",
    -- config = function()
    --   require("rose-pine").setup({
    --     disable_italics = true
    --   })
    --   vim.cmd.colorscheme("rose-pine-moon")
    -- end
  },

  {
    "Mofiqul/vscode.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   local c = require('vscode.colors').get_colors()
    --   require('vscode').setup({
    --     -- Alternatively set style in setup
    --     -- style = 'light'
    --
    --     -- Enable italic comment
    --     italic_comments = true,
    --
    --     -- Disable nvim-tree background color
    --     disable_nvimtree_bg = true,
    --
    --     -- Override colors (see ./lua/vscode/colors.lua)
    --     color_overrides = {
    --       vscLineNumber = '#FFFFFF',
    --     },
    --
    --     -- Override highlight groups (see ./lua/vscode/theme.lua)
    --     group_overrides = {
    --       -- this supports the same val table as vim.api.nvim_set_hl
    --       -- use colors from this colorscheme by requiring vscode.colors!
    --       Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    --     }
    --   })
    --   require('vscode').load()
    --   vim.cmd.colorscheme("vscode")
    -- end,
  },

  {
    "rebelot/kanagawa.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("plugins.configs.kanagawa")
    --   vim.cmd.colorscheme("kanagawa-dragon")
    -- end
  },

  {
    "aymenhafeez/tokyonight.nvim",
    -- dir = "~/Documents/git/tokyonight.nvim/",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("tokyonight").setup({
    --     styles = {
    --       comments = { italic = true },
    --       keywords = { italic = true },
    --       floats = "normal",
    --       statusline = "dark",
    --       sidebars = "dark"
    --     },
    --     sidebars = { "help", "qf", "toggleterm" },
    --   })
    --   vim.cmd.colorscheme("tokyonight")
    -- end
  },


  {
    -- "aymenhafeez/neodark.nvim",
    dir = "~/Documents/git/neodark.nvim/",
    -- lazy = false,
    -- priority = 1000,
    -- config = function ()
    --   vim.cmd.colorscheme("neodarker")
    -- end
  },

  {
    -- "aymenhafeez/scratch.nvim",
    dir = "~/Documents/git/scratch.nvim/",
    config = function()
      vim.cmd([[command! Scratch lua require'scratch'.ToggleScratch(config)]])
    end
  },

  -- { "aymenhafeez/vim-line-motion" }

}, options)
