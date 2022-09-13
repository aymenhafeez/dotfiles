local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
  return
end

local handlers = require("ah.lsp.handlers")
local capabilities = handlers.updated_capabilities

local lsp_flags = {
  debounce_text_changes = 50,
}

handlers.setup()
vim.o.updatetime = 100

local install_status_ok, lspinstaller = pcall(require, "nvim-lsp-installer")
if not install_status_ok then
  return
end

local servers = { "pyright", "sumneko_lua", "vimls", "texlab", "cssls", "remark_ls", "html", "jsonls" }
lspinstaller.setup {
  ensure_installed = servers,
  automatic_installation = true,
  ui = {
    border = "rounded",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
    }
  }
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = handlers.on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags
  }
end

lspconfig.sumneko_lua.setup {
  on_attach = handlers.on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

require("grammar-guard").init()
lspconfig.grammar_guard.setup({
  on_attach = handlers.on_attach,
  capabilities = capabilities,
  cmd = { "/usr/local/bin/ltex-ls" },
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown" },
      language = "en-GB",
      diagnosticSeverity = "info",
      checkFrequency = "save",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = false,
      },
      trace = { server = "verbose" },
      dictionary = {},
      disabledRules = {
        ["en-GB"] = { "MORFOLOGIK_RULE_EN_GB" },
      },
      hiddenFalsePositives = {},
    },
  },
})
