require("nvim-lsp-installer").setup({
  ensure_installed = {},
  automatic_installation = true,
  ui = {
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
    }
  }
})
