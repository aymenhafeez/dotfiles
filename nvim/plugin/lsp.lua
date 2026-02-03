vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  callback = function(args)
    vim.pack.add({ "https://github.com/j-hui/fidget.nvim" }, { load = false })
    require("fidget").setup({ notification = { window = { align = "top" } } })

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
      util_opts = util_opts or {}
      util_opts.max_width = 75
      util_opts.max_height = 20
      return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local map = vim.keymap.set

    map("n", "<leader>rn", vim.lsp.buf.rename)
    map({ "n", "x" }, "gra", vim.lsp.buf.code_action)
    map("n", "grr", vim.lsp.buf.references)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gO", vim.lsp.buf.document_symbol)
    map("n", "gW", vim.lsp.buf.workspace_symbol)
    map("n", "td", vim.lsp.buf.type_definition)

    local function client_supports_method(client, method, bufnr)
      ---@diagnostic disable-next-line: param-type-mismatch
      return client:supports_method(method, bufnr)
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if
        client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, args.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(args2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = args2.buf }
        end,
      })
    end

    if client and not client:supports_method "textDocument/willSaveWaitUntil"
        and client:supports_method "textDocument/formatting" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspGroup", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format { bufnr = args.buf, id = client.id, timeout_ms = 500 }
        end,
      })
    end

    if client and client:supports_method("textDocument/documentColor") then
      vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, args.buf) then
      map("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf })
      end, { desc = "Toggle Inlay Hints" })
    end
  end,
})

local servers = {
  "basedpyright",
  "lua_ls",
  "texlab",
  "vimls",
  "vtsls",
  "rust_analyzer",
  "clangd",
  "ruff"
}

vim.lsp.enable(servers)
