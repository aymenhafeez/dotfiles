local function on_init(client, result)
	if client:supports_method("textDocument/signatureHelp") then
		client.server_capabilities.signatureHelpProvider.triggerCharacters = {}
	end
	-- Handle off-spec "offsetEncoding" server capability
	if result.offsetEncoding then
		client.offset_encoding = result.offsetEncoding
	end
end

local lsp_augroup = vim.api.nvim_create_augroup("lsp#", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_augroup,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		vim.b[args.buf].lsp_client = client.name
		if client:supports_method("textDocument/documentHighlight") then
			vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
				group = lsp_augroup,
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
				group = lsp_augroup,
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
		if client:supports_method("textDocument/inlayHint") then
			vim.keymap.set("n", "yoh", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
			end, { buffer = args.buf, desc = "Toggle inlay hints" })
		end
		if client:supports_method("textDocument/codeLens") then
			vim.api.nvim_create_autocmd("LspProgress", {
				group = lsp_augroup,
				pattern = "*",
				callback = function(args2)
					if args2.data.params.value.kind == "end" and args2.buf == args.buf then
						vim.lsp.codelens.refresh({ bufnr = args.buf })
					end
				end,
			})
			vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
				group = lsp_augroup,
				buffer = args.buf,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = args.buf })
				end,
			})
			vim.lsp.codelens.refresh({ bufnr = args.buf })
		end
		if client:supports_method("textDocument/foldingRange") then
			vim.wo[0].foldmethod = "expr"
			vim.wo[0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
		if not client:supports_method("textDocument/willSaveWaitUntil") and client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = lsp_augroup,
				buffer = args.buf,
				callback = function()
					if vim.F.if_nil(client.settings.autoformat, vim.b.lsp_autoformat, vim.g.lsp_autoformat, false) then
						vim.lsp.buf.format({ bufnr = args.buf, id = args.data.client_id })
					end
				end,
			})
		end
		if client:supports_method("textDocument/completion") then
			if client.name == "lua-language-server" then
				client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
			end
			vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
		end
		if client:supports_method("textDocument/documentColor") then
			vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
		end
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	group = lsp_augroup,
	callback = function(args)
		vim.b[args.buf].lsp = nil
		vim.api.nvim_clear_autocmds({ group = lsp_augroup, buffer = args.buf })
	end,
})

vim.api.nvim_create_autocmd("LspProgress", {
	group = lsp_augroup,
	callback = function(args)
		local value = args.data.params.value
		if value.kind == "begin" then
			vim.api.nvim_ui_send("\027]9;4;1;0\027\\")
		elseif value.kind == "end" then
			vim.api.nvim_ui_send("\027]9;4;0;0\027\\")
		elseif value.kind == "report" then
			if value.percentage and value.percentage >= 0 and value.percentage <= 100 then
				vim.api.nvim_ui_send(string.format("\027]9;4;1;%d\027\\", value.percentage))
			end
		end
	end,
})

vim.lsp.config("*", { on_init = on_init, workspace_required = true })

local configs = {}
for _, c in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
	configs[vim.fn.fnamemodify(c, ":t:r")] = true
end
vim.lsp.enable(vim.tbl_keys(configs), vim.g.lsp_autostart or true)

