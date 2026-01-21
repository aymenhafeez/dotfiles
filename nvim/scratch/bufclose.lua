-- vim.api.nvim_get_current_buf() - gets current buffer number
-- vim.fn.bufnr('#') - gets the alternate buffer (the # buffer)
-- vim.api.nvim_buf_is_valid() - checks if a buffer number is valid
-- vim.api.nvim_set_current_buf() - switches current window to a buffer
-- vim.api.nvim_buf_delete() - deletes a buffer

--[[
1. Get current buffer number
2. Check if buffer is modified (if not forcing)
   → If modified and not forcing: error/warn
3. Get alternate buffer number
4. Validate alternate buffer
   → If invalid: find/create fallback buffer
5. Switch current window to alternate/fallback buffer
6. Delete the original buffer
7. Handle any errors gracefully
--]]

local function buf_delete()
	local bufnr = vim.api.nvim_get_current_buf()
	local alternate_buf = vim.fn.bufnr "#"

	if not vim.api.nvim_buf_is_valid(alternate_buf) then
		return
	end

	if vim.fn.getbufvar(bufnr, "&modified") then
		vim.notify("Buffer modifed. Save or use '!'", vim.log.levels.WARN)
	end

	if vim.api.nvim_buf_is_valid(alternate_buf) then
		vim.cmd "bprevious"
	end
end

vim.api.nvim_create_user_command("Bd", buf_delete(), {})
