return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function() require("ah.treesitter") end,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPost",
      opts = {
        enable = true,
        max_lines = 1,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
        on_attach = nil,
      }
    },
    {
      "nvim-treesitter/playground",
      cmd = { "TSPlayground", "TSHighlightCapturesUnderCursor" }
    }
  },
}
