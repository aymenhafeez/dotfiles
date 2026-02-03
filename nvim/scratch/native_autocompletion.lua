vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  callback = function(args)
    require("fidget").setup({ notification = { window = { align = "top" } } })

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
  util_opts = util_opts or {}
  util_opts.max_width = 75
  util_opts.max_height = 20
  return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
end

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

    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has "nvim-0.11" == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        return client:supports_method(method, bufnr)
      else
        ---@diagnostic disable-next-line: param-type-mismatch
        return client.supports_method(method, { bufnr = bufnr })
      end
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
          vim.lsp.buf.format { bufnr = args.buf, id = client.id }
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

    if client and client:supports_method("textDocument/completion") then
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "(", ")", "{", "}" }
      vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })

      vim.keymap.set("c", "<C-p>", function()
        if vim.fn.wildmenumode() ~= 0 then
          return "<C-p>"
        else
          return "<Up>"
        end
      end, { expr = true })

      vim.keymap.set("c", "<C-n>", function()
        if vim.fn.wildmenumode() ~= 0 then
          return "<C-n>"
        else
          return "<Down>"
        end
      end, { expr = true })

      vim.keymap.set("c", "<C-j>", function()
        if vim.fn.pumvisible() ~= 0 then
          return "<Down><Tab>"
        else
          return "<C-j>"
        end
      end, { expr = true })

      vim.keymap.set("c", "<C-k>", function()
        if vim.fn.pumvisible() ~= 0 then
          return "<Up><Tab>"
        else
          return "<C-k>"
        end
      end, { expr = true })

      vim.keymap.set("i", "<C-c>", function()
        if vim.fn.pumvisible() ~= 0 then
          return "<C-e>"
        else
          return "<C-c>"
        end
      end, { expr = true })

      vim.keymap.set("i", "<CR>", function()
        if vim.fn.pumvisible() ~= 0 then
          return "<C-y>"
        else
          return "<CR>"
        end
      end, { expr = true })

      vim.keymap.set("i", "<C-n>", function()
        if vim.fn.pumvisible() == 0 then
          return "<C-x><C-o>"
        else
          return "<Down>"
        end
      end, { expr = true })

      vim.keymap.set("i", "<C-p>", function()
        if vim.fn.pumvisible() == 0 then
          return "<C-x><C-p>"
        else
          return "<Up>"
        end
      end, { expr = true })
    end

    if client and client:supports_method "textDocument/signatureHelp" then
      vim.keymap.set("i", "<C-s>", function()
        vim.lsp.buf.signature_help {
          max_width = 65,
          max_height = 20,
          focusable = true,
          focus = true,
          close_events = { "InsertLeave" }
        }
      end, { buffer = args.buf })
    end

    vim.opt.updatetime = 300
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

vim.lsp.enable(servers, vim.g.lsp_autostart or true)
