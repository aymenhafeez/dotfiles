vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank {
			higroup = "Visual",
			timeout = 150,
		}
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("CursorPosition", {}),
	pattern = "*",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("HelpWindow", {}),
	pattern = "*",
	callback = function()
		local win_width = vim.api.nvim_win_get_width(0)
		if vim.bo.filetype == "help" then
			vim.opt_local.signcolumn = "no"
			vim.opt_local.statuscolumn = ""
			if win_width > 160 then
				vim.cmd "wincmd L"
				vim.cmd "vertical resize -12"
			else
				vim.cmd "resize +8"
			end
		end
	end,
})

-- not needed with the new experimental vim._extui
-- vim.opt.cmdheight = 0
-- local cmdGrp = vim.api.nvim_create_augroup("cmdline_height", { clear = true })
-- local function set_cmdheight(val)
-- 	if vim.opt.cmdheight:get() ~= val then
-- 		vim.opt.cmdheight = val
-- 		vim.cmd.redrawstatus()
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	group = cmdGrp,
-- 	callback = function()
-- 		set_cmdheight(1)
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = cmdGrp,
-- 	callback = function()
-- 		set_cmdheight(0)
-- 	end,
-- })
