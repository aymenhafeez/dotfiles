local function diagnostics()
	local diags = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })

	local num_errors = 0
	for _, v in ipairs(diags) do
		if v.severity == vim.diagnostic.severity.ERROR then
			num_errors = num_errors + 1
		end
	end

	local num_warnings = #diags - num_errors

	if num_errors == 0 and num_warnings == 0 then
		return " "
	elseif num_errors > 0 and num_warnings == 0 then
		return string.format("E: %d ", num_errors)
	elseif num_errors == 0 and num_warnings > 0 then
		return string.format("W: %d ", num_warnings)
	else
		return string.format("E: %d W: %d ", num_errors, num_warnings)
	end
end

local function filename(buf, fancy)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		name = "[No name]"
	else
		name = name:gsub("%%", "%%%%")
	end

	local fname = vim.fn.fnamemodify(name, ":~:.")
	local bufdir
	local parts = vim.split(fname, "/")
	if #parts > 4 then
		bufdir = vim.fn.pathshorten(fname, 1)
	else
		bufdir = fname
	end

	local parent = bufdir:match "^(.*/)"
	local tail = vim.fn.fnamemodify(name, ":t")

	local parent_hl, tail_hl
	if vim.bo.modified then
		parent_hl = "%1*"
		tail_hl = "%1*"
	elseif fancy then
		parent_hl = "%2*"
		tail_hl = "%3*"
	else
		parent_hl = ""
		tail_hl = ""
	end

	return string.format("%s %%<%s%s%s %%*", parent_hl, parent or "", tail_hl, tail)
end

local function get_file_icons(buf)
	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return ""
	end

	local extension = vim.fn.fnamemodify(buf, ":e")

	local icon = devicons.get_icon(buf, extension, { default = true })

	return icon ~= " " and " " .. icon or " "
end

local function git_info()
	local gitsigns = vim.b.gitsigns_status_dict
	if not gitsigns then
		return ""
	end

	local added = gitsigns.added or 0
	local changed = gitsigns.changed or 0
	local removed = gitsigns.removed or 0

	local signs = {}

	if gitsigns and gitsigns.head and gitsigns.head ~= "" then
		local branch_info = "#" .. gitsigns.head
		table.insert(signs, branch_info)
	end

	if added > 0 then
		table.insert(signs, "+" .. added)
	end
	if changed > 0 then
		table.insert(signs, "~" .. changed)
	end
	if removed > 0 then
		table.insert(signs, "-" .. removed)
	end

	if #signs > 0 then
		return table.concat(signs, " ")
	end
	return ""
end

local function word_count()
	local wc = vim.fn.wordcount()
	if wc.words == 0 then
		return ""
	end
	if wc.visual_words and wc.visual_words > 0 then
		return "(Word count: " .. wc.visual_words .. "/" .. wc.words .. ") "
	end
	return "(Word count: " .. wc.words .. ") "
end

local function tabline()
	local tabpagenr = vim.fn.tabpagenr()
	local items = {}

	for i = 1, vim.fn.tabpagenr "$" do
		local hi = (i == tabpagenr) and "TabLineSel" or "TabLine"
		local cwd = vim.fn.pathshorten(vim.fn.fnamemodify(vim.fn.getcwd(-1, i), ":~:."))
		table.insert(items, string.format("%%#%s#%%%dT %d %s ", hi, i, i, cwd))
	end

	table.insert(items, "%#TabLineFill#%T")
	return table.concat(items)
end

local function statusline()
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_get_current_win()
	local term = vim.bo[buf].buftype == "terminal"
	local curwin = tonumber(vim.g.actual_curwin) == win
	local fancy = curwin and not term
	local bufname = vim.api.nvim_buf_get_name(buf)

	local items = {}

	-- Session indicator
	if vim.v.this_session == "" then
		table.insert(items, "")
	else
		table.insert(items, " $")
	end

	-- Filename
	-- table.insert(items, get_file_icons(bufname))
	table.insert(items, filename(buf, fancy))

	-- Readonly flag
	if vim.bo.readonly then
		table.insert(items, "%r ")
	else
		table.insert(items, "")
	end

	-- Preview window flag
	if vim.wo.previewwindow then
		table.insert(items, "%w ")
	else
		table.insert(items, "")
	end

	table.insert(items, " " .. git_info() .. "  ")

	local writing_ft = { tex = true, markdown = true, text = true }
	if writing_ft[vim.bo.filetype] then
		local wc = word_count()
		if wc ~= "" then
			table.insert(items, wc)
		end
	end

	-- Separator
	table.insert(items, "%=")

	-- Diagnostics
	table.insert(items, diagnostics())

	-- Highlight
	if fancy then
		table.insert(items, "%4*")
	else
		table.insert(items, "")
	end

	-- File format and encoding
	if vim.bo.modifiable and not vim.bo.readonly then
		local t = {}

		local ff = vim.bo.fileformat
		if ff ~= "unix" then
			if ff == "dos" then
				table.insert(t, "CRLF")
			else
				table.insert(t, "CR")
			end
		end

		local fenc = vim.bo.fileencoding
		if fenc ~= "utf-8" and fenc ~= "" then
			table.insert(t, fenc)
		end

		if #t > 0 then
			table.insert(items, string.format(" %s ", table.concat(t, " ")))
		else
			table.insert(items, "")
		end
	else
		table.insert(items, "")
	end

	-- Highlight
	if fancy then
		table.insert(items, "%8*")
	else
		table.insert(items, "")
	end

	-- Filetype with LSP client
	local ft = vim.bo.filetype
	if ft == "" then
		table.insert(items, " ")
	else
		local clients = vim.lsp.get_clients { bufnr = 0 }

		local client_names = {}
		for _, client in ipairs(clients) do
			table.insert(client_names, client.name)
		end

		local lsp_client = table.concat(client_names, ", ")

		if next(clients) ~= nil then
			table.insert(items, string.format(" %s/%s ", ft, lsp_client))
		else
			table.insert(items, string.format(" %s ", ft))
		end
	end

	-- Highlight
	if fancy then
		table.insert(items, "%9*")
	else
		table.insert(items, "")
	end

	-- Position info
	local line = vim.fn.getpos(".")[2]
	local col = vim.fn.getpos(".")[3]
	table.insert(items, string.format(" %3d:%3d ", line, col) .. "%P ")

	return table.concat(items)
end

return {
	statusline = statusline,
	tabline = tabline,
}
