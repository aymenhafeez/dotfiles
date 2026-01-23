local term = require "terminal"

vim.keymap.set("t", "<C-[><C-[>", "<C-\\><C-n>")

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-W>2<i")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-W>2>i")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-W>2-i")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-W>2+i")


vim.keymap.set({ "n", "t" }, "<leader>tt", function()
	term.toggle_terminal {}
end)

vim.keymap.set({ "n", "t" }, "<leader>vt", function()
	term.toggle_terminal { direction = "right" }
end)

vim.keymap.set({ "n", "t" }, "<leader><leader>t", function()
	vim.cmd "tabnew"
	vim.cmd "term"
	vim.cmd "startinsert"
end)

vim.keymap.set({ "n", "t" }, "<leader>ft", function()
	term.toggle_terminal { floating = true }
end)

-- WIP
local function term_winbar()
	local buflist = vim.api.nvim_list_bufs()
	local items = {}

	for _, buf in pairs(buflist) do
		if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "terminal" then
			local bufname = vim.api.nvim_buf_get_name(buf)
			local bufname_short = vim.fn.pathshorten(bufname)

			table.insert(items, bufname_short)
		end
	end

	if next(items) == nil then
		return ""
	else
		return table.concat(items, " ")
	end
end

local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "*",
	callback = function()
		-- vim.opt_local.number = false  -- off by default I think
		-- vim.opt_local.relativenumber = false
		vim.opt_local.cursorline = false
		vim.opt_local.scrolloff = 0
		vim.wo.statuscolumn = ""
		vim.wo.winfixwidth = true
		vim.wo.winfixheight = true

		vim.bo.filetype = "terminal"

		-- vim.cmd "set winhighlight=Normal:TerminalNormal"
	end,
})

vim.api.nvim_create_autocmd("TermEnter", {
	callback = function()
		vim.wo.winbar = term_winbar()
	end
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = group,
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.cmd "startinsert"
		end
	end,
})

local job_id = 0
vim.keymap.set("n", "<leader>pt", function()
	vim.cmd.new()
	vim.cmd.term()
	vim.api.nvim_win_set_height(0, 20)

	job_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>ji", function()
	local cmd = vim.fn.input "Cmd > "
	vim.fn.chansend(job_id, { cmd .. "\r\n" })
end)
