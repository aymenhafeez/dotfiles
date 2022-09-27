local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
  return
end

local handlers = require("ah.lsp.handlers")
local capabilities = handlers.lsp_capabilities
local updated_capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
local lspconfig_ui = require("lspconfig.ui.windows")

handlers.setup()
vim.o.updatetime = 100

local install_status_ok, lspinstaller = pcall(require, "nvim-lsp-installer")
if not install_status_ok then
  return
end

require("grammar-guard").init()

local servers = {
  pyright = {},
  vimls = {},
  texlab = {},
  cssls = {},
  remark_ls = {},
  html = {},
  jsonls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { 'vim' }
        },
        --[[ -- folke/lua-dev.nvim takes care of this
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 1000,
          preloadFileSize = 1000,
        }, ]]
        telemetry = {
          enable = false,
        },
      },
    },
  },
  grammar_guard = {
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
  },
}

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
lspconfig_ui.default_options.border = "rounded"

local options = {
  on_attach = handlers.on_attach,
  capabilities = updated_capabilities,
  flags = {
    debounce_text_changes = 150,
  }
}

for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  lspconfig[server].setup(opts)
end
