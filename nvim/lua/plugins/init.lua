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

lazy.setup({
  -- -- need to work out how to get this to work with Lazy.nvim
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
  --   use(opts)
  -- end

  { "nvim-lua/plenary.nvim" },

  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end
  },

  { "nvim-lua/popup.nvim" },

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
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.configs.notify")
    end
  },

  { "moll/vim-bbye" },

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

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      require("plugins.configs.lualine")
    end
  },

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
      -- {"nvim-treesitter/nvim-treesitter-textobjects"},
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
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
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

  -- lsp stuff --

  { "williamboman/nvim-lsp-installer" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("ah.lsp")
    end,
    -- dependencies = {
    --   -- {
    --   --   "SmiteshP/nvim-navic",
    --   --   config = function()
    --   --     require("plugins.configs.navic")
    --   --   end,
    --   --   module = { "nvim-navic" }
    --   -- },
    -- },
  },

  -- {
  --   "aymenhafeez/breadcrumb.nvim",
  --   config = function()
  --     require("plugins.configs.breadcrumbs")
  --   end,
  -- },

{
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    config = function()
        require("plugins.configs.saga")
    end,
    },

  -- cmp --

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

  { "SirVer/ultisnips" },

  { "brymer-meneses/grammar-guard.nvim" },

  { "nanotee/luv-vimdocs" },

  { "milisims/nvim-luaref" },

  {
    "jupyter-vim/jupyter-vim",
    ft = "python"
  },

  -- colourschemes --

  { "catppuccin/nvim" },
  { "embark-theme/vim" },
  { "AlexvZyl/nordic.nvim" },
  { "Mofiqul/vscode.nvim" },
  {
    "aymenhafeez/onedark.nvim",
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   require("onedark").setup {
    --     style = "dark"
    --   }
    --   require("onedark").load()
    --   -- vim.cmd.colorscheme("onedark")
    -- end
  },
  {
    "rebelot/kanagawa.nvim",
    -- config = function()
    --   vim.cmd.colorscheme("kanagawa-dragon")
    -- end
  },

  {
    "ntk148v/habamax.nvim",
    dependencies={ "rktjmp/lush.nvim" }
  },

  {
    "NvChad/base46"
  },

  {
    "folke/tokyonight.nvim",
    -- config = function ()
    --   vim.cmd.colorscheme("tokyonight-night")
    -- end
  },

  {
    "aymenhafeez/neodark.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme("neodark")
    end
  },
  -- local_use "neodark.nvim"

  -- {" aymenhafeez/OxfDictionary.nvim "},
  -- local_use "OxfDictionary.nvim"

  {
    "aymenhafeez/scratch.nvim",
    config = function()
      vim.cmd([[command! Scratch lua require'scratch'.ToggleScratch(config)]])
    end
  },

  -- local_use "scratch.nvim"

  -- { "aymenhafeez/vim-line-motion" }
  -- local_use "vim-line-motion"

})
