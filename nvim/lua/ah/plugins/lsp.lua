return {
  -- LSP configuration using native Neovim 0.11+ vim.lsp.config API
  -- Mason for installing LSP servers
  {
    "mason-org/mason.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      -- Load LSP configs using the new vim.lsp.config API
      -- This runs after mason is ready
      require "ah.lspconfig"
    end,
  },
  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {},
  },
}
