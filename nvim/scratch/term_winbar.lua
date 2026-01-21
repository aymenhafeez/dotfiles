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

vim.print(term_winbar())
