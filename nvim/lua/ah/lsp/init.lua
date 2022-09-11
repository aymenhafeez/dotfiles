local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local function notify(content, type, opts, force)
  if force then
    if packer_plugins['nvim-notify'] ~= nil and packer_plugins['nvim-notify'].loaded then
        require('notify')(content, type, opts)
    end
    return
  end

  vim.notify(content, type, opts)
end

vim.diagnostic.config({
  virtual_text = {
    prefix = " ●",
    spacing = 7
  },
  float = {
    focusable = false,
    scope = "cursor",
    source = true,
    header = "",
    prefix = function(diagnostic)
      local icon, highlight
      if diagnostic.severity == 1 then
        icon = " "
        highlight = "DiagnosticError"
      elseif diagnostic.severity == 2 then
        icon = " "
        highlight = "DiagnosticWarn"
      elseif diagnostic.severity == 3 then
        icon = " "
        highlight = "DiagnosticInfo"
      elseif diagnostic.severity == 4 then
        icon = " "
        highlight = "DiagnosticHint"
      end
      return icon .. " ", highlight
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

--[[ -- show diagnostic message on CursorHold
local floatDiagnostics = vim.api.nvim_create_augroup("FloatDiagnostics", { clear = true })
vim.api.nvim_create_autocmd("CursorHold" , {
  pattern = "*",
  command = "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})",
  group = floatDiagnostics
}) ]]

map("n", "<leader>e", vim.diagnostic.open_float, opts)
map("n", "<leader>dn", vim.diagnostic.goto_next, opts)
map("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
map("n", "<leader>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- neovim 0.8 (nightly) uses server_capabilities instead of resolved_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=#353d4b
    hi! LspReferenceText cterm=bold ctermbg=red guibg=#353d4b
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#353d4b
    ]]
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gd", require("telescope.builtin").lsp_definitions, bufopts)
  map("n", "gp", "<cmd>Lspsaga preview_definition<CR>", bufopts)
  map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, bufopts)
  map("n", "gr", require("telescope.builtin").lsp_references, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
  map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "<leader>lr", "<cmd>:LspRestart<CR>", bufopts)

  vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = "Format current buffer with LSP" })

  if client.server_capabilities.documentSymbolProvider then
    local navic = require "nvim-navic"
    navic.attach(client, bufnr)
  end

  notify(string.format("[LSP] %s", client.name, ""), "info", { title = "[LSP] Active" }, true)

end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local updated_capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_flags = {
  debounce_text_changes = 50,
}

vim.o.updatetime = 100

local servers = { "pyright", "sumneko_lua", "vimls", "texlab", "cssls", "remark_ls", "html", "jsonls" }

require("nvim-lsp-installer").setup {
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
  require("lspconfig")[lsp].setup {
    on_attach = on_attach,
    capabilities = updated_capabilities,
    lsp_flags = lsp_flags
  }
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        globals = {'vim'},
      },
      -- workspace = {
      --   library = vim.api.nvim_get_runtime_file("", true),
      -- },
      telemetry = {
        enable = false,
      },
    },
  },
}
-- require("grammar-guard").init()
-- require("lspconfig").grammar_guard.setup({
--   on_attach = on_attach,
--   capabilities = lsp_capabilities,
--   cmd = { "/usr/local/bin/ltex-ls" },
--   settings = {
--     ltex = {
--       enabled = { "latex", "tex", "bib", "markdown" },
--       language = "en-GB",
--       diagnosticSeverity = "info",
--       checkFrequency = "save",
--       setenceCacheSize = 2000,
--       additionalRules = {
--         enablePickyRules = false,
--       },
--       trace = { server = "verbose" },
--       dictionary = {},
--       disabledRules = {},
--       hiddenFalsePositives = {},
--     },
--   },
-- })

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = border,
  }),
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
  util_opts = util_opts or {}
  util_opts.border = util_opts.border or border
  return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
end