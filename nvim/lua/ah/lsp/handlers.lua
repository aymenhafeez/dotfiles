local M = {}

local border = require("ah.utils").border

function M.setup()
  local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = ""
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    virtual_text = {
      prefix = " ●",
      spacing = 7
    },
    float = {
      focusable = false,
      scope = "cursor",
      source = "always",
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
    severity_sort = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
    util_opts = util_opts or {}
    util_opts.border = util_opts.border or border("FloatBorder")
    util_opts.max_width = 60
    util_opts.max_height = 15
    return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
  end

end

local function _notify(content, type, opts, force)
  if force then
    if packer_plugins['nvim-notify'] ~= nil and packer_plugins['nvim-notify'].loaded then
      require('notify')(content, type, opts)
    end
    return
  end

  vim.notify(content, type, opts)
end

-- local function _lsp_highlight_document(client)
--   if client.server_capabilities.documentHighlightProvider then
--     local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
--     vim.api.nvim_clear_autocmds({ group = "lsp_document_highlight" })
--     vim.api.nvim_create_autocmd("CursorHold", {
--       pattern = "<buffer>",
--       callback = vim.lsp.buf.document_highlight,
--       group = lsp_document_highlight,
--     })
--     vim.api.nvim_create_autocmd("CursorMoved", {
--       pattern = "<buffer>",
--       callback = vim.lsp.buf.clear_references,
--       group = lsp_document_highlight,
--     })
--   end
--
-- -- -- show diagnostic message on CursorHold
-- --   local floatDiagnostics = vim.api.nvim_create_augroup("FloatDiagnostics", { clear = true })
-- --   vim.api.nvim_create_autocmd("CursorHold", {
-- --     pattern = "<buffer>",
-- --     command = "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})",
-- --     group = floatDiagnostics
-- --   })
--
-- end

function M.on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  map("n", "<leader>e", vim.diagnostic.open_float, opts)
  map("n", "<leader>dh", vim.diagnostic.hide, opts)
  map("n", "<leader>ds", vim.diagnostic.show, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "<leader>q", vim.diagnostic.setloclist, opts)

  map("n", "gD", vim.lsp.buf.declaration, bufopts)
  map("n", "gd", require("telescope.builtin").lsp_definitions, bufopts)
  map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, bufopts)
  map("n", "gr", require("telescope.builtin").lsp_references, bufopts)
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gi", vim.lsp.buf.implementation, bufopts)
  map("n", "<leader>k", vim.lsp.buf.signature_help, bufopts)
  map("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "<leader>lr", "<cmd>:LspRestart<CR>", bufopts)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })

  if client.server_capabilities.documentSymbolProvider then
    local navic = require "nvim-navic"
    navic.attach(client, bufnr)
  end

  _notify(string.format("[LSP] %s", client.name, ""), "info", { title = "[LSP] Active" }, true)

  -- -- this works but doesn't
  -- if client.server_capabilities.documentHighlightProvider then
  --   local lsp_signature_help = vim.api.nvim_create_augroup("lsp_signature_help", { clear = true })
  --   vim.api.nvim_clear_autocmds({ group = "lsp_signature_help" })
  --   vim.api.nvim_create_autocmd("CursorHoldI", {
  --     pattern = "<buffer>",
  --     callback = function()
  --       if vim.bo.filetype == { 'tex', 'markdown' } then
  --         return
  --       else
  --         vim.lsp.buf.signature_help()
  --       end
  --     end,
  --     group = lsp_signature_help,
  --   })
  --   vim.api.nvim_create_autocmd("CursorMovedI", {
  --     pattern = "<buffer>",
  --     callback = vim.lsp.buf.clear_references,
  --     group = lsp_signature_help,
  --   })
  -- end

-- -- show diagnostic message on CursorHold
--   local floatDiagnostics = vim.api.nvim_create_augroup("FloatDiagnostics", { clear = true })
--   vim.api.nvim_create_autocmd("CursorHold", {
--     pattern = "<buffer>",
--     command = "lua vim.diagnostic.open_float(nil, {focus=false, scope='cursor'})",
--     group = floatDiagnostics
--   })

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

end

function M.get_lua_runtime()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/";
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end

  -- loads the `lua` files from nvim into the runtime
  result[vim.fn.expand("$VIMRUNTIME/lua")] = true

  -- TODO: figure out how to get these to work
  result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

  return result;
end

M.lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
M.lsp_capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return M
