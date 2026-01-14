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
vim.lsp.start({
	name = 'lua_ls',
	cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/lua-language-server" },
	on_attach = function(client, bufnr)
		vim.lsp.completion.enable(true, client.id, bufnr, {
			autotrigger = true,
			convert = function(item)
				return { abbr = item.label:gsub('%b()', '') }
			end,
		})
	end,
})

vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspGroup", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end
  end,
})

vim.diagnostic.config {
	virtual_text = true,
}

vim.o.winborder = "rounded"

local function get_current_buf()
	local bufnr = vim.api.nvim_get_current_buf()
	local buf = vim.api.nvim_buf_get_name(bufnr)

	return { bufnr, buf }
end

vim.print(get_current_buf())

