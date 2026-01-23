local capabilities = nil
if pcall(require, 'blink.cmp') then
	capabilities = require('blink.cmp').get_lsp_capabilities()
end

return {
	cmd = { vim.fn.expand('~/.local/share/lua-ls/bin/lua-language-server') },
	filetypes = { 'lua' },
	root_markers = { '.emmyrc.json', '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
	capabilities = capabilities,
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = 'tab',
					indent_size = '2',
					tab_width = '2',
					quote_style = 'double',
				},
			},
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'equals' },
				disable = {
					'missing-fields',
					'undefined-doc-name',
				},
			},
			completion = {
				callSnippet = 'Replace',
				keywordSnippet = 'Replace',
				showWord = 'Fallback',
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					'${3rd}/luv/library',
					'${3rd}/busted/library',
					'${3rd}/luassert/library',
				},
				maxPreload = 5000,
				preloadFileSize = 10000,
				ignoreDir = {
					'.git',
					'.github',
					'node_modules',
					'.vscode',
					'.idea',
				},
			},
			hint = {
				enable = true,
				setType = true,
				paramName = 'Disable',
				paramType = true,
			},
			semantic = {
				enable = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
