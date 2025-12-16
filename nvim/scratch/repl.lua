local current_job_id
current_job_id = current_job_id or -1

local current_cmd
current_cmd = current_cmd or nil

local set_job_id = function(job_id)
	local bufnr = vim.api.nvim_get_current_buf()
	job_id = job_id or vim.bo[bufnr].channel

	print("JOB ID SET:", job_id)
	current_job_id = job_id
end

local set_job_command = function(cmd)
	current_cmd = cmd or vim.fn.input "Cmd > "
end

local send_to_term = function(input)
	input = input or current_cmd or vim.fn.input "Cmd > "

	vim.fn.chansend(current_job_id, { input .. "\r\n" })
end

vim.keymap.set("n", "<leader>js", function()
	set_job_id()
end)

vim.keymap.set("n", "<leader>jc", function()
	set_job_command()
	send_to_term()
end)
