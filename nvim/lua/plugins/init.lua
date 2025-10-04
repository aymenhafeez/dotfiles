local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({

  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   dependencies = { 'rcarriga/nvim-notify' },
  --   config = function()
  --     require("plugins.configs.snacks")
  --   end,
  -- },

  -- lazy.nvim

  { 'NMAC427/guess-indent.nvim' },

  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      require("plugins.configs.indent_scope")
    end
  },

  {
    "kylechui/nvim-surround",
    opts = {}
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  {
    "moll/vim-bbye"
  },

  {
    "tpope/vim-scriptease",
    cmd = {
      "Messages",
      "Verbose"
    }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      require("plugins.configs.neotree")
    end
  },

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("plugins.configs.scrollbar")
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("plugins.configs.zen")
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("plugins.configs.telescope")
    end,
  },

  -- LSP

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

    },
    config = function()
      require("plugins.configs.lsp")
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
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      anti_conceal = {
        disabled_modes = { "n" }
      },
      latex = {
        enabled = true,
        render_modes = false
      },
      completions = {
        lsp = { enabled = true }
      },
      heading = {
        enabled = true,
        signs = { "" },
        width = 'block',
        right_pad = 2,
        left_pad = 1,
        border = true,
        border_virtual = true
      },
      code = {
        width = 'block',
        left_pad = 1,
        right_pad = 7,
        border = "thick"
      },
      callout = {
        custom  = { raw = '[!CUSTOM]',  rendered = '󰨸 Custom callout',  highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
      },
      indent = {
        enabled = true,
        icon = ""
      }
    },
  },

  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    "let-def/texpresso.vim",
    ft = 'tex',
    config = function()
      vim.cmd(':lua require("texpresso").texpresso_path = "/home/aymen/bin/texpresso"')
    end
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_imaps_enabled = false
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_view_enabled = true
    end
  },

  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true
    end
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 12
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },

  {
  "akinsho/bufferline.nvim",
    config = function()
      require("plugins.configs.bufferline")
    end
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.configs.toggleterm")
    end,
    cmd = { "ToggleTerm", "TermExec" }
  },

  { 'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
    dependencies = {
      {"nvim-treesitter/nvim-treesitter-textobjects"},
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require("plugins.configs.context")
        end
      },
      {
        "nvim-treesitter/playground",
        cmd = { "TSPlayground", "TSHighlightCapturesUnderCursor" }
      }
    }
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end
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

  -- colorschemes

  {
    "oonamo/ef-themes.nvim",
    priority = 1000,
    opts = {
      dark = 'ef-owl',
      light = 'ef-eagle',
    },
    -- config = function()
    --   vim.cmd.colorscheme('ef-owl')
    -- end
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'cool'
      }
      -- require('onedark').load()
    end
  },

  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {},
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      require('solarized').setup(opts)
      -- vim.cmd.colorscheme 'solarized'
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = true },
        },
        on_highlights = function(hl, c)
          local header = "#7aa2f7"
          local header_modified = "#f7768e"
          hl.StatusLineHeader = {
            bg = header,
            fg = c.bg
          }
          hl.StatusLineHeaderModified = {
            bg = header_modified,
            fg = c.bg
          }
        end
      }
      -- vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  {
    'vague2k/vague.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        style = {
          strings = 'none'
        },
        on_highlights = function(highlights, colors)
          highlights.NeoTreeWinSeparator.fg = colors.bg
          highlights.NeoTreeWinSeparator.bg = colors.bg
          highlights.NeoTreeNormal.bg = '#0f0f0f'
          highlights.NeoTreeNormalNC.bg = '#0f0f0f'
          highlights.NeoTreeEndOfBuffer.bg = '#0f0f0f'
          highlights.MatchParen.fg = '#e8b589'
          highlights.MatchParen.bg = '#252530'
          highlights.StatusLineNC.bg = '#1c1c24'
          highlights.TreesitterContext.bg = '#1c1c24'
          highlights.TreesitterContextLineNumber.bg = '#1c1c24'
          highlights.LspReferenceText.bg = '#252530'
          highlights.LspReferenceWrite.bg = '#252530'
          highlights.LspReferenceRead.fg = '#252530'
          highlights.StatusLineTerm.bg = '#1c1c24'
          highlights.StatusLineHeader = { fg = colors.fg, bg = '#606079' }
          highlights.StatusLineHeaderModified = { fg = colors.bg, bg = '#c48282' }
        end,
      })
      -- vim.cmd("colorscheme vague")
    end
  },
})
