local M = {}

M.job_id = nil

M.get_selection = function()
	local start_pos = vim.api.nvim_buf_get_mark(0, "<")
	local end_pos = vim.api.nvim_buf_get_mark(0, ">")
	local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

	return table.concat(text, "\n")
end

M.create_repl = function()
	if not M.job_id then
		vim.cmd "20new"
		-- M.repl_id = vim.fn.termopen "python3"
		M.job_id = vim.fn.jobstart({ "python3" }, { term = true })

		vim.wait(100, function()
			return false
		end)
	end
end

M.send_repl_line = function()
	M.create_repl()

	vim.fn.chansend(M.job_id, vim.fn.getline "." .. "\n")
end

function M.send_repl_selection()
	M.create_repl()

	local selection = M.get_selection()
	vim.fn.chansend(M.job_id, selection)
end

return M
