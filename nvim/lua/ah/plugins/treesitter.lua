return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPost",
      opts = {
        max_lines = 2,
      },
    },
    {
      "nvim-treesitter/playground",
      cmd = { "TSPlayground", "TSHighlightCapturesUnderCursor" },
    },
  },
  config = function()
    require("ah.treesitter").setup()
  end,
}
