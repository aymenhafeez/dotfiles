local virt_lines_ns = vim.api.nvim_create_namespace "on_diagnostic_jump"
local group = vim.api.nvim_create_augroup("VirtLines", { clear = true })

--- @param diagnostic? vim.Diagnostic
--- @param bufnr integer
local function on_jump(diagnostic, bufnr)
	if not diagnostic then return end

	vim.diagnostic.show(
		virt_lines_ns,
		bufnr,
		{ diagnostic },
		{ virtual_lines = { current_line = true }, virtual_text = false }
	)

	-- Clear virtual_lines on CursorMoved event
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = group,
		buffer = bufnr,
		once = true,
		callback = function()
			vim.diagnostic.hide(virt_lines_ns, bufnr)
		end
	})
end

vim.diagnostic.config({ jump = { on_jump = on_jump } })

-- vim.diagnostic.config {
-- 	severity_sort = true,
-- 	-- signs = false,
-- 	virtual_text = true,
-- 	jump = {
-- 		on_jump = on_jump,
-- 		wrap = false,
-- 	},
-- 	float = {
-- 		source = true
-- 	}
-- }
--
-- :h diagnostic-toggle-virtual-lines-example
vim.keymap.set("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end)

-- local diagnostic_float = nil
--
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		if vim.fn.mode() ~= "n" then
-- 			return
-- 		end
--
-- 		local diagnostics = vim.diagnostic.get(0, { scope = "cursor" })
-- 		if #diagnostics == 0 then
-- 			return
-- 		end
--
-- 		vim.diagnostic.open_float(nil, {
-- 			focus = false,
-- 			scope = "cursor",
-- 			border = "rounded",
-- 		})
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("WinClosed", {
-- 	callback = function(args)
-- 		if diagnostic_float and tostring(diagnostic_float) == args.match then
-- 			diagnostic_float = nil
-- 		end
-- 	end,
-- })
