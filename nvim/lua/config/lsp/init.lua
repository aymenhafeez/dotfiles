local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

-- 1. Set up nvim-lsp-installer first!
lsp_installer.setup {}

-- 2. (optional) Override the default configuration to be applied to all servers.
lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = on_attach
    }
)

-- 3. Loop through all of the installed servers and set it up via lspconfig
for _, server in ipairs(lsp_installer.get_installed_servers()) do
  lspconfig[server.name].setup {}
end

-- lsp server settings
require("config.lsp.lsp_installer")
-- load custom settings for sumeneko lua
require("config.lsp.settings.sumneko_lua")
-- require("config.lsp.settings.pyright")
-- require("config.lsp.settings.texlab")
-- require("config.lsp.settings.vimls")

-- local lspconfig = require 'lspconfig'
-- local configs = require 'lspconfig/configs'

-- require("config.lsp.handlers").setup()

vim.diagnostic.config({
    virtual_text = false,
    -- virtual_text = {
    --     prefix = '●'
    -- },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 150
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=#abb2bf guibg=#1f2335]]

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- Do not forget to use the on_attach function
-- require 'lspconfig'.settings.setup { handlers=handlers }

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
