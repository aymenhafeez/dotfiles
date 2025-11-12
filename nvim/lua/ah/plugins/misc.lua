return {
  { "NMAC427/guess-indent.nvim" },
  { "kylechui/nvim-surround", event = "InsertEnter", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "tjdevries/colorbuddy.nvim" },
  {
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
    init = function()
      vim.cmd.cnoreabbrev "bd Bw"
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        top_down = false,
        max_width = 50,
        render = "wrapped-compact",
      }
      vim.notify = require "notify"
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
