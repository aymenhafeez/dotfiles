return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  keys = {
    vim.keymap.set("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor),
  },
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
