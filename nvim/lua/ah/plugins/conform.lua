return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = function()
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        json = { "fixjson" },
      },
    },
  },
}
