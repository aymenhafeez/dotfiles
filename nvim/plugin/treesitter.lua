-- Enable treesitter highlighting for specific filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "vim", "markdown", "rust", "latex" },
	callback = function()
		vim.treesitter.start()
	end,
	desc = "Enable treesitter highlighting",
})
