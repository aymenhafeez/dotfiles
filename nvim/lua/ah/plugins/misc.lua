return {
  { "NMAC427/guess-indent.nvim" },
  { "kylechui/nvim-surround", event = "InsertEnter", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "tpope/vim-scriptease" },
  -- {
  --   "luukvbaal/statuscol.nvim",
  --   config = function()
  --     require("statuscol").setup {
  --       setopt = true,
  --     }
  --   end,
  -- },

  -- i think there's a treesitter parser for comments -> @comment.todo
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   },
  -- },

  {
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
    init = function()
      vim.cmd.cnoreabbrev "bd Bw"
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      auto_save = false,
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
  },
}
