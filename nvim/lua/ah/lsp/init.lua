require "ah.lsp.servers"

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
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
		-- map("n", "K", vim.lsp.buf.hover)
		map("n", "]d", function()
			vim.diagnostic.jump { count = 1, float = true }
		end)
		map("n", "[d", function()
			vim.diagnostic.jump { count = -1, float = true }
		end)

		-- local telescope = require "telescope.builtin"
		-- local themes = require "telescope.themes"

		-- map("n", "<leader>rn", vim.lsp.buf.rename)
		-- map({ "n", "x" }, "gra", vim.lsp.buf.code_action)
		-- map("n", "grr", function()
		-- 	telescope.lsp_references(themes.get_ivy {})
		-- end)
		-- map("n", "gi", telescope.lsp_implementations, { desc = "Go to implementation" })
		-- map("n", "gd", telescope.lsp_definitions, { desc = "Go to definition (first declaration)" })
		-- map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration (all declarations)" })
		-- map("n", "gO", telescope.lsp_document_symbols)
		-- map("n", "gW", telescope.lsp_dynamic_workspace_symbols)
		-- map("n", "td", telescope.lsp_type_definitions, { desc = "Go to type definition" })
		-- map("n", "K", vim.lsp.buf.hover)
		-- map("n", "]d", function()
		-- 	vim.diagnostic.jump { count = 1, float = true }
		-- end)
		-- map("n", "[d", function()
		-- 	vim.diagnostic.jump { count = -1, float = true }
		-- end)

		-- map("n", "<leader>rn", vim.lsp.buf.rename)
		-- map({ "n", "x" }, "gra", "<cmd>FzfLua lsp_code_actions<CR>")
		-- map("n", "grr", "<cmd>FzfLua lsp_references<CR>")
		-- map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>")
		-- map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>")
		-- map("n", "gD", "<cmd>FzfLua lsp_declarations<CR>")
		-- map("n", "gO", "<cmd>FzfLua lsp_document_symbols<CR>")
		-- map("n", "gW", "<cmd>FzfLua lsp_workspace_symbols<CR>")
		-- map("n", "<leader>sl", "<cmd>FzfLua lsp_find<CR>")
		-- map("n", "td", "<cmd>FzfLua lsp_typedefs<CR>")
		-- map("n", "K", vim.lsp.buf.hover)
		-- map("n", "]d", function()
		-- 	vim.diagnostic.jump { count = 1, float = true }
		-- end)
		-- map("n", "[d", function()
		-- 	vim.diagnostic.jump { count = -1, float = true }
		-- end)

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

local diagnostic_signs = {
  -- stylua: ignore start
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.INFO] = " ",
  [vim.diagnostic.severity.HINT] = " ",
	-- stylua: ignore end
}

vim.diagnostic.config {
	severity_sort = true,
	-- signs = {
	-- 	text = diagnostic_signs,
	-- },
	signs = false,
	status = {
		text = diagnostic_signs,
	},
	virtual_text = true,
	jump = {
		-- on_jump = vim.diagnostic.open_float,
		wrap = false,
	},
}
