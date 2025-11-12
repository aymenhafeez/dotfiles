return {
  {
    "lervag/vimtex",
    ft = "tex",
    keys = {
      { "<leader>ct", "<cmd>VimtexTocToggle<CR>", desc = "Toggle contents" },
    },
    init = function()
      vim.g.vimtex_imaps_enabled = false
      vim.g.vimtex_mappings_enabled = false
      vim.g.vimtex_view_enabled = true
    end,
  },
  {
    "brianhuster/live-preview.nvim",
    ft = { "markdown", "md" },
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
}
