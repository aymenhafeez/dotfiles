vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = vim.keymap.set
    local telescope = require "telescope.builtin"

    map("n", "<leader>rn", vim.lsp.buf.rename)
    map({ "n", "x" }, "gra", vim.lsp.buf.code_action)
    map("n", "grr", telescope.lsp_references)
    map("n", "gi", telescope.lsp_implementations, { desc = "Go to implementation" })
    map("n", "gd", telescope.lsp_definitions, { desc = "Go to definition (first declaration)" })
    map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration (all declarations)" })
    map("n", "gO", telescope.lsp_document_symbols)
    map("n", "gW", telescope.lsp_dynamic_workspace_symbols)
    map("n", "td", telescope.lsp_type_definitions, { desc = "Go to type definition" })
    map("n", "<leader>dh", vim.diagnostic.hide, { desc = "Hide diagnostics" })
    map("n", "<leader>ds", vim.diagnostic.show, { desc = "Unhide diagnostics" })
    map("n", "K", vim.lsp.buf.hover)
    map("n", "]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end)
    map("n", "[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end)

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

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
        end,
      })
    end

    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, { desc = "Toggle Inlay Hints" })
    end

    vim.opt.updatetime = 300
  end,
})

vim.diagnostic.config {
  severity_sort = true,
  signs = {
    text = {
      -- stylua: ignore start
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      -- stylua: ignore end
    },
  },
  virtual_text = true,
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, util_opts, ...)
  util_opts = util_opts or {}
  util_opts.max_width = 75
  util_opts.max_height = 15
  return orig_util_open_floating_preview(contents, syntax, util_opts, ...)
end

local capabilities = nil
if pcall(require, "blink.cmp") then
  capabilities = require("blink.cmp").get_lsp_capabilities()
end

vim.lsp.config.pylsp = {
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/pylsp" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        -- let ruff handle linting
        pycodestyle = { enabled = true },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
        autopep8 = { enabled = true },
      },
    },
  },
}

vim.lsp.config.ruff = {
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
  capabilities = capabilities,
}

vim.lsp.config.remark_ls = {
  cmd = { "remark-language-server", "--stdio" },
  filetypes = { "markdown" },
  root_markers = { ".remarkrc", ".remarkrc.json", ".remarkrc.js", "package.json", ".git" },
  capabilities = capabilities,
  settings = {
    remark = {
      requireConfig = false,
    },
  },
}

vim.lsp.config.lua_ls = {
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

vim.lsp.enable { "pylsp", "ruff", "remark_ls", "lua_ls" }

local ensure_installed = {
  "python-lsp-server",
  "ruff",
  "lua-language-server",
  "stylua",
}

require("mason-tool-installer").setup { ensure_installed = ensure_installed }
