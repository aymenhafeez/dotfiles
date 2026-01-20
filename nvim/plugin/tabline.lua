-- will get back to this

_G.tabline = {}

function _G.tabline()
	local s = ""
	local tabs = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_get_current_tabpage()

	for _, tab in ipairs(tabs) do
		local tab_num = vim.api.nvim_tabpage_get_number(tab)
		local is_current = (tab == current_tab)

		s = s .. "%" .. tab_num .. "T"
		s = s .. (is_current and "%#TabLineSel#" or "%#TabLine#")
		s = s .. " " .. tab_num .. ":"

		local win = vim.api.nvim_tabpage_get_win(tab)
		local buf = vim.api.nvim_win_get_buf(win)
		local bufname = vim.api.nvim_buf_get_name(buf)

		local filename
		if bufname == "" then
			filename = "No name"
		else
			filename = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ":~:."))
		end

		s = s .. " " .. filename .. " "

		if vim.api.nvim_get_option_value("modified", { buf = buf }) then
			s = s .. "[+]"
		end
	end

	s = s .. "%#TabLineFill#%T"

	return s
end

vim.go.tabline = "%!v:lua.tabline()"
