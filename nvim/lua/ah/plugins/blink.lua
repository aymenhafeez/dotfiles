return  {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  config = function() require("ah.completion") end,
  dependencies = {
    {
      "xzbdmw/colorful-menu.nvim",
      opts = {}
    },
    "onsails/lspkind.nvim",
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
  },
}
