return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "rcarriga/nvim-notify",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      {
        "nvim-tree/nvim-web-devicons",
        enabled = vim.g.have_nerd_font,
      },
    },
    config = function()
      require "ah.telescope"
    end,
  },
}
