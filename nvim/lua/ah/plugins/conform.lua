return {
  {
    "stevearc/conform.nvim",
    -- opts = {
    -- },
    config = function()
      require("conform").setup {
        format_on_save = function()
          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          json = { "fixjson" },
        },
      }
    end,
  },
}
