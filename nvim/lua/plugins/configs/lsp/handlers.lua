local M = {}

local utils = require("ah.utils")

function M.setup()
  local signs = utils.diagnostic_signs
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
          icon = " "
          highlight = "DiagnosticError"
        elseif diagnostic.severity == 2 then
          icon = " "
          highlight = "DiagnosticWarn"
        elseif diagnostic.severity == 3 then
          icon = " "
          highlight = "DiagnosticInfo"
        elseif diagnostic.severity == 4 then
          icon = " "
          highlight = "DiagnosticHint"
        end
        return icon .. " ", highlight
      end,
    },
    signs = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "none" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "none" })

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
    util_opts = util_opts or {}
    util_opts.border = util_opts.border or utils.border("CmpBorder")
    util_opts.max_width = 60
    util_opts.max_height = 15
    return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
  end

end

function M.on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local map = vim.keymap.set

  map("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostic" })
  map("n", "<leader>dh", vim.diagnostic.hide, { noremap = true, silent = true, desc = "Hide diagnostics" })
  map("n", "<leader>ds", vim.diagnostic.show, { noremap = true, silent = true, desc = "Unhide diagnostics" })
  map("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Go to next diagnostic" })
  map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Go to previous diagnostic" })
  map("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Open diagnostics in location list window" })

  map("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, buffer = bufnr, desc = "Go to declaration" })
  map("n", "gd", require("telescope.builtin").lsp_definitions, { noremap = true, silent = true, buffer = bufnr, desc = "Go to definition" })
  map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions, { noremap = true, silent = true, buffer = bufnr, desc = "Go to type definition" })
  map("n", "gr", require("telescope.builtin").lsp_references, { noremap = true, silent = true, buffer = bufnr, desc = "Show references" })
  map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "" })
  map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, buffer = bufnr, desc = "List implementations" })
  map("n", "<leader>k", vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = bufnr, desc = "Show signature help" })
  map("i", "<C-k>", vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = bufnr, desc = "" })
  map("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, buffer = bufnr, desc = "Show code action" })
  map("n", "<leader>lr", "<cmd>:LspRestart<CR>", { noremap = true, silent = true, buffer = bufnr, desc = "Restart language server" })

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  vim.o.updatetime = 150
end

function M.get_lua_runtime()
  local result = {};
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. "/lua/";
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand("$VIMRUNTIME/lua")] = true

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

