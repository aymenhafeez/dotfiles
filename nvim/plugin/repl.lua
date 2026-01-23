local job_id = nil

local get_selection = function()
	local start_pos = vim.api.nvim_buf_get_mark(0, "<")
	local end_pos = vim.api.nvim_buf_get_mark(0, ">")
	local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

	return table.concat(text, "\n")
end

local create_repl = function()
	local width = math.floor(vim.o.columns * 0.45)
	local win_width = vim.api.nvim_win_get_width(0)
	if not job_id then
		if win_width < 180 then
			vim.cmd "new"
		else
			vim.cmd(width .. "vnew")
		end
		job_id = vim.fn.jobstart({ "python3" }, { term = true })

		vim.wait(100, function()
			return false
		end)
	end
end

local send_repl_line = function()
	create_repl()

	vim.fn.chansend(job_id, vim.fn.getline "." .. "\n")
end

local function send_repl_selection()
	create_repl()

	local selection = get_selection()
	vim.fn.chansend(job_id, selection)
end

vim.keymap.set("n", "<leader>pp", function() send_repl_line() end)

vim.keymap.set("n", "<leader>vv", function() send_repl_selection() end)

vim.keymap.set("n", "<leader>vp", function()
	vim.cmd 'exe "normal vip \\<Esc>"'
	send_repl_selection()
end)
