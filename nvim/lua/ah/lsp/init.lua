require "ah.lsp.servers"

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

		-- if client and client:supports_method("textDocument/completion") then
		-- 	-- if client.name == "lua-language-server" then
		-- 	-- client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
		-- 	-- end
		-- 	client.server_capabilities.completionProvider.triggerCharacters = { ".", ":" }
		-- 	vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
		-- 		autotrigger = true,
		-- 		convert = function(item)
		-- 			return { abbr = item.label:gsub("%b()", "") }
		-- 		end,
		-- 	})
		--
		-- 	vim.api.nvim_create_autocmd("CompleteDone", {
		-- 		group = vim.api.nvim_create_augroup("lsp-signature-on-complete", { clear = false }),
		-- 		buffer = args.buf,
		-- 		callback = function()
		-- 			-- Check if a completion item was selected
		-- 			local completed_item = vim.v.completed_item
		-- 			if completed_item and next(completed_item) ~= nil then
		-- 				-- Small delay to let the completion settle
		-- 				vim.defer_fn(function()
		-- 					if client and client:supports_method("textDocument/signatureHelp") then
		-- 						-- Temporarily suppress "No signature help" notifications
		-- 						local original_notify = vim.notify
		-- 						vim.notify = function(msg, level, opts)
		-- 							if not (type(msg) == "string" and msg:match("No signature help")) then
		-- 								original_notify(msg, level, opts)
		-- 							end
		-- 						end
		--
		-- 						vim.lsp.buf.signature_help()
		--
		-- 						-- Restore after a short delay
		-- 						vim.defer_fn(function()
		-- 							vim.notify = original_notify
		-- 						end, 200)
		-- 					end
		-- 				end, 50) -- 50ms delay
		-- 			end
		-- 		end,
		-- 	})
		-- end

		-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
		-- 	if vim.snippet.active { direction = 1 } then
		-- 		return "<Cmd>lua vim.snippet.jump(1)<CR>"
		-- 	else
		-- 		return "<C-j>"
		-- 	end
		-- end, { desc = "...", expr = true, silent = true })
		--
		-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
		-- 	if vim.snippet.active { direction = -1 } then
		-- 		return "<Cmd>lua vim.snippet.jump(-1)<CR>"
		-- 	else
		-- 		return "<C-k>"
		-- 	end
		-- end, { desc = "...", expr = true, silent = true })
		--
		-- if client and client:supports_method "textDocument/signatureHelp" then
		-- 	vim.keymap.set("i", "<C-s>", function()
		-- 		vim.lsp.buf.signature_help {
		-- 			max_width = 65,
		-- 			max_height = 20,
		-- 			focusable = true,
		-- 			focus = true,
		-- 			close_events = { "InsertLeave" }
		-- 		}
		-- 	end, { buffer = args.buf })
		-- end

		vim.opt.updatetime = 300
	end,
})

vim.diagnostic.config {
	severity_sort = true,
	signs = false,
	virtual_text = true,
	jump = {
		wrap = false,
	},
}
