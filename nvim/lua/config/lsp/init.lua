local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- lsp server settings
require("config.lsp.lsp_installer")

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 7
  },
  float = {
    focusable = false,
    scope = "cursor",
    source = true,
    header = "",
    -- pos = 1,
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
      return icon .. "  ", highlight
    end,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local signature_opts = {
  bind = true,
  floating_window_above_cur_line = false,
  -- doc_lines = 0,
  hint_prefix = " ",
  -- max_height = 12,
  -- max_width = 80,
  floating_window = false,
  handler_opts = {
    border = "rounded"
  },
  toggle_key = '<C-c><C-e>'
}

map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- neovim 0.8 (nightly) uses server_capabilities instead of resolved_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
    hi! LspReferenceRead cterm=bold ctermbg=red guibg=#313742
    hi! LspReferenceText cterm=bold ctermbg=red guibg=#313742
    hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#313742
    ]]
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- see `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gD', vim.lsp.buf.declaration, bufopts)
  map('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
  map('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, bufopts)
  map('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
  map('n', 'K', vim.lsp.buf.hover, bufopts)
  map('n', 'gi', vim.lsp.buf.implementation, bufopts)
  map('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting,
    { desc = 'Format current buffer with LSP' })

  require "lsp_signature".setup(signature_opts)
  require "lsp_signature".on_attach(signature_opts)

  if client.server_capabilities.documentSymbolProvider then
    local navic = require "nvim-navic"
    navic.attach(client, bufnr)
  end

end

local lsp_flags = {
  -- default = 150
  debounce_text_changes = 50,
}

local servers = { 'pyright', 'sumneko_lua', 'vimls', 'texlab', 'cssls', 'remark_ls', 'html' }

require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    lsp_flags = lsp_flags
  }
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require 'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      -- workspace = {
      --   -- Make the server aware of Neovim runtime files
      --   library = vim.api.nvim_get_runtime_file("", true),
      -- },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
-- require'lspconfig'.ltex.setup{}
-- require("grammar-guard").init()
-- require("lspconfig").grammar_guard.setup({
--   cmd = { '/usr/local/bin/ltex-ls' }, -- add this if you install ltex-ls yourself
-- 	settings = {
-- 		ltex = {
-- 			enabled = { "latex", "tex", "bib", "markdown" },
-- 			language = "en",
-- 			diagnosticSeverity = "hint",
--             checkFrequency="save",
-- 			setenceCacheSize = 2000,
-- 			additionalRules = {
-- 				enablePickyRules = true,
-- 				motherTongue = "en",
-- 			},
-- 			trace = { server = "verbose" },
-- 			dictionary = {},
-- 			disabledRules = {},
-- 			hiddenFalsePositives = {},
-- 		},
-- 	},
-- })

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.updatetime = 150
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=#abb2bf guibg=#1f2335]]

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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
