local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
  return
end

require('mason').setup({
  ui = {
    border = "none",
    width = 0.8,
    height = 0.8
  }
})
require('mason-lspconfig').setup()

local handlers = require("ah.lsp.handlers")
local capabilities = handlers.lsp_capabilities
local updated_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local lspconfig_ui = require("lspconfig.ui.windows")

handlers.setup()

local servers = {
  pyright = {},
  vimls = {},
  texlab = {},
  cssls = {},
  remark_ls = {},
  html = {},
  jsonls = {},
  lua_ls = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 1000,
        preloadFileSize = 1000,
      },
      telemetry = { enable = false },
    },
  },
  rust_analyzer = {
    cmd = { "rustup", "run", "stable", "rust-analyzer" }
  }
}

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = updated_capabilities,
      on_attach = handlers.on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

lspconfig_ui.default_options.border = "none"
