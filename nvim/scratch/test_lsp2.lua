vim.opt.breakindent = true
vim.opt.completeopt = "menu,menuone,popup,noinsert,fuzzy"
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.jumpoptions = "view"
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars:append("precedes:<,extends:>")
vim.opt.number = true
vim.opt.pumborder = "rounded"
vim.opt.pumheight = 15
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.wildmode = "longest:full,full"
vim.opt.winborder = "rounded"
vim.opt.wrap = false

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.lsp.config.lua_ls = {
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/lua-language-server" },
  root_markers = { ".luarc.json" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
    },
  },
}

vim.lsp.config.texlab = {
  bibtexFormatter = "texlab",
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/texlab" },
  filetypes = { "tex", "plaintex", "bib" },
}

vim.lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        autoSearchPaths = true,
        autoImportCompletions = true,
      },
    },
  },
}

vim.lsp.enable { "lua_ls", "texlab", "basedpyright" }

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspGroup", {}),
  callback = function(args)
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has "nvim-0.11" == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        return client:supports_method(method, bufnr)
      else
        ---@diagnostic disable-next-line: param-type-mismatch
        return client.supports_method(method, { bufnr = bufnr })
      end
    end


    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

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

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, args.buf) then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf })
      end, { desc = "Toggle Inlay Hints" })
    end

    if client:supports_method("textDocument/signatureHelp") then
      -- Manual trigger
      vim.keymap.set("i", "<C-s>", function()
          vim.lsp.buf.signature_help({
            max_width = 65,
            max_height = 20,
            focusable = true,
            focus = true,
          })
        end,
        { buffer = args.buf, desc = "LSP Signature Help" })

      -- Get trigger characters from server capabilities
      -- local triggers = { "(", "," } -- Fallback defaults
      -- if client.server_capabilities.signatureHelpProvider
      --     and client.server_capabilities.signatureHelpProvider.triggerCharacters then
      --   triggers = client.server_capabilities.signatureHelpProvider.triggerCharacters
      -- end
      --
      -- -- Auto-trigger on trigger characters
      -- vim.api.nvim_create_autocmd("TextChangedI", {
      --   buffer = args.buf,
      --   callback = function()
      --     -- Don't trigger if completion is already visible
      --     if vim.fn.pumvisible() == 1 then
      --       return
      --     end
      --
      --     local col = vim.fn.col('.') - 1
      --     local line = vim.fn.getline('.')
      --     local char = line:sub(col, col)
      --
      --     for _, trigger in ipairs(triggers) do
      --       if char == trigger then
      --         vim.lsp.buf.signature_help({
      --           max_width = 65,
      --           max_height = 20,
      --           focusable = false,
      --           focus = false,
      --           -- close_events = { "InsertLeave", "CursorMovedI" },
      --         })
      --         break
      --       end
      --     end
      --   end,
      -- })
    end

    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspGroup', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    vim.opt.updatetime = 300
  end,
})

vim.diagnostic.config {
  virtual_text = true,
}

vim.cmd [[
cnoremap <expr> <C-P> wildmenumode() ? '<C-P>' : '<Up>'
cnoremap <expr> <C-N> wildmenumode() ? '<C-N>' : '<Down>'
cnoremap <expr> <C-J> pumvisible() ? '<Down><Tab>' : '<C-J>'
cnoremap <expr> <C-K> pumvisible() ? '<Up><Tab>' : '<C-K>'
inoremap <expr> <C-C> pumvisible() ? '<C-E>' : '<C-C>'
inoremap <expr> <CR> pumvisible() ? '<C-Y>' : '<CR>'

" :h ins-completion
"function! CleverTab()
"	 if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"			return "\<Tab>"
"	 else
"			return "\<C-N>"
"	 endif
"endfunction
"inoremap <Tab> <C-R>=CleverTab()<CR>
]]

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
  if vim.snippet.active({ direction = 1 }) then
    return '<Cmd>lua vim.snippet.jump(1)<CR>'
  else
    return '<Tab>'
  end
end, { desc = '...', expr = true, silent = true })

vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)

vim.keymap.set("v", "<space>x", ":.lua<cr>")

vim.keymap.set("n", "<space>so", "<cmd>source %<CR>")
