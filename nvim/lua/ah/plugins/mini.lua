return {
	{
		"nvim-mini/mini.notify",
		version = "*",
		config = function()
			require("mini.notify").setup {
				lsp_progress = { enable = false },
				window = {
					config = function()
						local has_statusline = vim.o.laststatus > 0
						local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
						return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
					end,
				},
			}
			vim.keymap.set("n", "<leader>tn", "<cmd>lua MiniNotify.show_history()<CR>")
		end,
	},
	-- {
	-- 	"nvim-mini/mini.files",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.files").setup {}
	-- 	end,
	-- },
	-- {
	-- 	"nvim-mini/mini.pick",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.pick").setup {}
	-- 	end,
	-- },
}
