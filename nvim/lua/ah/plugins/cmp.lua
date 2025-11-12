return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "/usr/share/awesome/lib/", words = { "awesome" } },
            { "nvim-dap-ui" },
          },
        },
      },
    },
    config = function()
      require "ah.cmp"
    end,
  },
}
