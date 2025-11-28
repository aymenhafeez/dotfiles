return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("notify").setup {
            top_down = false,
            max_width = 50,
            render = "wrapped-compact",
            stages = "static",
          }
          vim.notify = require "notify"
        end,
      },
      {
        dir = "~/Documents/projects/telescope-tab-buffers.nvim/",
        keys = {
          {
            "<leader>ab",
            function()
              require("telescope").extensions.tab_buffers.tab_buffers()
            end,
            desc = "Tab Buffers",
          },
        },
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "nvim-tree/nvim-web-devicons", opts = {} },
    },
    config = function()
      require "ah.telescope"
    end,
  },
}
