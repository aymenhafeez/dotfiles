vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
      util_opts = util_opts or {}
      util_opts.max_width = 75
      util_opts.max_height = 15
      return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    map("n", "gW", vim.lsp.buf.workspace_symbol, { desc = "Search workspace symbols" })
    map("n", "td", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.api.nvim_create_autocmd("LspProgress", {
      buffer = args.buf,
      callback = function(ev)
        local value = ev.data.params.value or {}
        local msg = value.message or "done"

        -- rust analyszer in particular has really long lsp messages so truncate them
        if #msg > 40 then
          msg = msg:sub(1, 37) .. "..."
        end

        -- :h LspProgress
        vim.api.nvim_echo({ { msg } }, false, {
          id = "lsp",
          kind = "progress",
          title = value.title,
          status = value.kind ~= "end" and "running" or "success",
          percent = value.percentage,
        })
      end,
    })

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
      end, { desc = "Toggle inlay hints" })
    end

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if vim.snippet.active({ direction = 1 }) then
        return "<Cmd>lua vim.snippet.jump(1)<CR>"
      else
        return "<C-j>"
      end
    end, { desc = "Jump to next snippet placeholder", expr = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if vim.snippet.active({ direction = -1 }) then
        return "<Cmd>lua vim.snippet.jump(-1)<CR>"
      else
        return "<C-k>"
      end
    end, { desc = "Jump to previous snippet placeholder", expr = true, silent = true })
  end,
})

local servers = {
  "basedpyright",
  "lua_ls",
  "vimls",
  "vtsls",
  "rust_analyzer",
  "clangd",
  "ruff",
  "texlab"
}

require("pack_lazy").on("BufReadPre", function()
  vim.lsp.enable(servers)
end)
