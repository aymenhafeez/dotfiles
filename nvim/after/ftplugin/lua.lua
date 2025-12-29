vim.opt_local.autoindent = true
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2
vim.opt.formatoptions = "cqjrn"

vim.api.nvim_create_user_command("LUA", function()
	local output = vim.fn.execute "source %"
	local split_lines = vim.split(output, "\n")
	vim.fn.setqflist({}, "a", {
		title = "LUA",
		lines = split_lines,
	})
	vim.cmd "copen"
	vim.cmd "normal G"
end, {})

vim.keymap.set("n", "<leader>lu", "<cmd>LUA<CR>")
