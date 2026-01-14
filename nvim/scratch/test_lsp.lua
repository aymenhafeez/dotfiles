vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

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
				callSnippet = "replace",
			},
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }
      }
		},
	},
}

vim.lsp.enable "lua_ls"

vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspGroup", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})
