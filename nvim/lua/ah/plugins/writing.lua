return {
  {
    "lervag/vimtex",
    ft = 'tex',
    init = function()
      vim.g.vimtex_imaps_enabled = false
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_view_enabled = true
    end
  },
  {
    "let-def/texpresso.vim",
    ft = 'tex',
    config = function()
      vim.cmd(':lua require("texpresso").texpresso_path = "/home/aymen/bin/texpresso"')
    end
  },
  { "SirVer/ultisnips" },
  {
    'brianhuster/live-preview.nvim',
    ft = { 'markdown', 'md' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
}
