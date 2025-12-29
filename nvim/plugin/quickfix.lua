-- send output of command to quickfix window
vim.api.nvim_create_user_command("OP", function(opts)
	local args = opts.fargs
	local output = vim.fn.execute(vim.fn.join(args, " "))
	local split_lines = vim.split(output, "\n")
	vim.fn.setqflist({}, "a", {
		title = "Output",
		lines = split_lines,
	})
	vim.cmd "copen"
	vim.cmd "normal G"
end, { nargs = "*" })

-- view messages in quickfix window
vim.api.nvim_create_user_command("Mess", function()
	local output = vim.fn.execute "messages"
	local split_lines = vim.split(output, "\n")
	vim.fn.setqflist({}, "r", {
		title = "Messages",
		lines = split_lines,
	})
	vim.cmd "copen"
	vim.cmd "normal G"
end, {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})
