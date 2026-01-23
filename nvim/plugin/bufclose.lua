local function buf_delete()
	local alternate_buf = vim.fn.bufnr "#"

	if vim.bo.modified then
		return vim.notify("Buffer modifed", vim.log.levels.WARN)
	else
		if alternate_buf == -1 then
			local empty_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_set_current_buf(empty_buf)
		else
			vim.api.nvim_set_current_buf(alternate_buf)
		end
	end
end

vim.api.nvim_create_user_command("Bdelete", buf_delete, {})
vim.keymap.set("c", "bd", "Bdelete")
