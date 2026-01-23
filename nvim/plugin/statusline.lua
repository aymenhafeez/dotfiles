_G.statusline = {}

local function hl(group, str)
	return string.format("%%#%s#%s%%*", group or "", str or "")
end

local modes = {
	["n"] = "Normal",
	["no"] = "N·oper",
	["v"] = "Visual",
	["V"] = "V·Line",
	[""] = "V·Blck",
	["s"] = "Select",
	["S"] = "S·Line",
	[""] = "S·Block",
	["i"] = "Insert",
	["ic"] = "I·Comp",
	["ix"] = "I·Comp",
	["R"] = "Replace",
	["Rv"] = "V·Rep",
	["c"] = "Cmmand",
	["cv"] = "V·Ex",
	["ce"] = "Ex",
	["r"] = "Hit<CR>",
	["rm"] = "More",
	["r?"] = "Confirm",
	["!"] = "Shell",
	["t"] = "Term  ",
	["ntT"] = "nTerminal",
}

function statusline.mode()
	local mode = modes[vim.fn.mode()] or " "
	local mode_format = string.format(" %s ", mode)
	if mode == "Normal" then
		return hl("StatusLineHeaderNorm", mode_format)
	elseif mode == "Cmmand" then
		return hl("StatusLineHeaderCmd", mode_format)
	elseif mode == "Term  " then
		return hl("StatusLineHeaderTerm", mode_format)
	else
		return hl("StatusLineHeader", mode_format)
	end
end

function statusline.mode_nc()
	local mode = modes[vim.fn.mode()] or " "
	local mode_format = string.format(" %s ", mode)
	return hl("StatusLineNC", mode_format)
end

function statusline.position()
	local line = vim.fn.getpos(".")[2]
	local col = vim.fn.getpos(".")[3]
	if vim.bo.buftype == "terminal" then
		return hl("StatusLineTerm", string.format(" %3d:%3d ", line, col) .. "%P ")
	else
		return hl("StatusLinePos", string.format(" %3d:%3d ", line, col) .. "%P ")
	end
end

function statusline.position_nc()
	local line = vim.fn.getpos(".")[2]
	local col = vim.fn.getpos(".")[3]
	return string.format(" %3d:%3d ", line, col) .. "%P "
end

function statusline.git_branch()
	local gitsigns = vim.b.gitsigns_status_dict
	if not gitsigns then
		return ""
	end

	local branch = {}
	if gitsigns and gitsigns.head and gitsigns.head ~= "" then
		-- local branch_info = " " .. gitsigns.head
		local branch_info = "#" .. gitsigns.head
		table.insert(branch, branch_info)
	end

	if #branch > 0 then
		return table.concat(branch, "")
	end
end

function statusline.git_info()
	local gitsigns = vim.b.gitsigns_status_dict
	if not gitsigns then
		return ""
	end

	local added = gitsigns.added or 0
	local changed = gitsigns.changed or 0
	local removed = gitsigns.removed or 0

	local signs = {}

	-- if gitsigns and gitsigns.head and gitsigns.head ~= "" then
	-- 	local branch_info = " " .. gitsigns.head
	-- 	table.insert(signs, branch_info)
	-- end

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
		return "[" .. table.concat(signs, ", ") .. "]"
	end
	return ""
end

function statusline.word_count()
	local wc = vim.fn.wordcount()
	if wc.words == 0 then
		return ""
	end
	if wc.visual_words and wc.visual_words > 0 then
		return "Word count: " .. wc.visual_words .. "/" .. wc.words
	end
	return " Word count: " .. wc.words
end

local writing_ft = { tex = true, markdown = true, text = true }

function statusline.version()
	local version = vim.version()
	return hl("StatusLineHeaderbold", " nvim ")
			.. hl("StatusLineHeaderNorm", "v" .. version.major .. "." .. version.minor .. "." .. version.patch .. " ")
end

function statusline.info()
	local info = {}

	-- local mode = modes[vim.fn.mode()] or " "
	-- if mode == "Normal" then
	-- 	table.insert(info, " >> ")
	-- else
	-- 	table.insert(info, hl("Number", " >> "))
	-- end

	local buf = vim.api.nvim_get_current_buf()
	local readonly = vim.api.nvim_get_option_value("readonly", { buf = buf })
	if readonly then
		table.insert(info, "%r")
	end

	local branch = statusline.git_branch()
	if branch ~= "" then
		table.insert(info, branch)
	end

	local git = statusline.git_info()
	if git ~= "" then
		table.insert(info, git)
	end

	if writing_ft[vim.bo.filetype] then
		local wc = statusline.word_count()
		if wc ~= "" then
			table.insert(info, wc)
		end
	end

	return #info > 0 and " " .. table.concat(info, " ") or " "
end

local function get_buffer_icon(buf, filetype)
	local present, devicons = pcall(require, "nvim-web-devicons")
	if not present then
		return ""
	end

	local icon = devicons.get_icon(buf, filetype, { default = true }) or ""
	return icon ~= "" and icon .. " " or ""
end

function statusline.diag()
	local diag = vim.diagnostic.get(0)
	if next(diag) == nil then
		return " "
	else
		return " " .. vim.diagnostic.status(0) .. " "
	end
end

local function supports_method(method)
	local clients = vim.lsp.get_clients { bufnr = 0 }

	for _, client in pairs(clients) do
		if client.server_capabilities[method] then
			return true
		end
	end
	return false
end

function statusline.lsp_action()
	if supports_method "codeActionProvider" then
		return "󰮗"
	end
	return ""
end

function statusline.filetype()
	local filetype = vim.bo.filetype:gsub("^%l", string.upper)
	return filetype
end

function statusline.lsp_status()
	local filetype = vim.bo.filetype:gsub("^%l", string.upper)
	local buf_current = vim.api.nvim_get_current_buf()
	local readonly = vim.api.nvim_get_option_value("readonly", { buf = buf_current })
	local ro_filetype = readonly and " [RO]" or ""

	local clients = vim.lsp.get_clients { bufnr = 0 }
	if next(clients) == nil then
		return hl("StatusLineLsp", " " .. filetype .. " ")
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	local attached_client = table.concat(client_names, ", ")

	return hl("StatusLineLsp", " " .. filetype .. "/" .. attached_client .. " " .. ro_filetype)
end

function statusline.lsp_status_nc()
	local filetype = vim.bo.filetype:gsub("^%l", string.upper)

	local clients = vim.lsp.get_clients { bufnr = 0 }
	if next(clients) == nil then
		return hl("StatusLineNC", " " .. filetype .. " ")
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	local attached_client = table.concat(client_names, ", ")

	return hl("StatusLineNC", " " .. filetype .. "/" .. attached_client .. " ")
end

local spinner_idx = 0
local icons = {
	-- spinner = {
	-- 	"🌑 ",
	-- 	"🌒 ",
	-- 	"🌓 ",
	-- 	"🌔 ",
	-- 	"🌕 ",
	-- 	"🌖 ",
	-- 	"🌗 ",
	-- 	"🌘 ",
	-- },
	spinner = {
		"⣾",
		"⣽",
		"⣻",
		"⢿",
		"⡿",
		"⣟",
		"⣯",
		"⣷",
	},
	done = " ",
}
local progress_active = false

function statusline.lsp_progress()
	local status = vim.lsp.status()
	if status ~= "" then
		progress_active = true
		spinner_idx = (spinner_idx % #icons.spinner) + 1
		return icons.spinner[spinner_idx] .. " " .. status
	elseif progress_active then
		progress_active = false
		return "DONE " .. icons.done
	else
		return ""
	end
end

function statusline.centered_buffer()
	local buf = vim.api.nvim_buf_get_name(0)
	local bufname = vim.fn.fnamemodify(buf, ":t")

	local path
	-- path = vim.fn.fnamemodify(buf, ":~:.")
	path = vim.fn.fnamemodify(buf, ":~:.:h")

	local bufdir
	local parts = vim.split(path, "/")
	if #parts > 3 then
		bufdir = vim.fn.pathshorten(path, 1)
	else
		bufdir = path
	end

	local icon = buf ~= "" and get_buffer_icon(vim.fn.fnamemodify(buf, ":e"), vim.bo.filetype) or "󰧮 "
	local modified = vim.bo.modified and "[+]" or ""

	local buffer_text_plain = icon .. bufdir .. "/" .. bufname .. modified
	local buffer_len = vim.fn.strdisplaywidth(buffer_text_plain)

	local mode = modes[vim.fn.mode()] or " "
	local mode_format = string.format(" %s ", mode)
	local mode_len = vim.fn.strdisplaywidth(mode_format)

	-- local search = statusline.search_count()
	-- local search_len = vim.fn.strdisplaywidth(search)

	local info_plain = ""

	-- info_plain = info_plain .. " >>  "

	local buf_current = vim.api.nvim_get_current_buf()
	local readonly = vim.api.nvim_get_option_value("readonly", { buf = buf_current })
	if readonly then
		info_plain = info_plain .. " [RO]"
	end

	if writing_ft[vim.bo.filetype] then
		local wc = statusline.word_count()
		if wc ~= "" then
			info_plain = info_plain .. "  " .. wc
		end
	end

	local git = statusline.git_info()
	info_plain = info_plain .. " " .. git

	local branch = statusline.git_branch()
	if branch ~= nil then
		info_plain = info_plain .. " " .. branch
	end

	local info_len = vim.fn.strdisplaywidth(info_plain)
	local left_len = mode_len + info_len

	local win_width
	if vim.opt.laststatus:get() == 3 then
		win_width = vim.api.nvim_list_uis()[1].width
	else
		win_width = vim.api.nvim_win_get_width(0)
	end

	local padding = math.max(0, math.floor((win_width - buffer_len) / 2) - left_len)

	local buffer_text
	if vim.bo.buftype == "terminal" then
		buffer_text = icon .. bufdir .. "/" .. hl("StatusLineBufNameTerm", bufname) .. modified
	else
		buffer_text = icon .. bufdir .. "/" .. hl("StatusLineBufName", bufname) .. modified
	end

	return string.rep(" ", padding) .. buffer_text
end

-- normal buffer name display in any align container
function statusline.buffer()
	local buf = vim.api.nvim_buf_get_name(0)
	if buf == "" then
		return "  " .. get_buffer_icon(buf, "") .. "[No name]"
	end

	local bufdir = vim.fn.fnamemodify(buf, ":~:.:h")
	local parts = vim.split(buf, "/")

	local bufdir_short
	if #parts > 3 then
		bufdir_short = vim.fn.pathshorten(bufdir)
	else
		bufdir_short = bufdir
	end

	local bufname = vim.fn.fnamemodify(buf, ":t")
	local modified = vim.bo.modified and "[+]" or ""

	local filetype = vim.fn.fnamemodify(buf, ":e")
	local icon = get_buffer_icon(buf, filetype)

	if vim.bo.buftype == "terminal" then
		return hl("StatusLineBufDir", " " .. get_buffer_icon(buf, "terminal") .. bufdir_short .. "/")
				.. hl("StatusLineBufName", bufname)
				.. modified
	else
		return hl("StatusLineBufDir", " " .. icon .. bufdir_short .. "/")
				.. hl("StatusLineBufName", bufname)
				.. modified
	end
end

function statusline.buffer_nc()
	local buf = vim.api.nvim_buf_get_name(0)
	local bufdir = vim.fn.fnamemodify(buf, ":~:.:h")
	local parts = vim.split(buf, "/")

	local bufdir_short
	if #parts > 3 then
		bufdir_short = vim.fn.pathshorten(bufdir)
	else
		bufdir_short = bufdir
	end

	local bufname = vim.fn.fnamemodify(buf, ":t")
	local modified = vim.bo.modified and "[+]" or ""

	local filetype = vim.fn.fnamemodify(buf, ":e")
	local icon = get_buffer_icon(buf, filetype)

	if vim.bo.buftype == "terminal" then
		return "  " .. get_buffer_icon(buf, "terminal") .. bufdir_short .. "/" .. bufname .. modified
	end
	return "  " .. icon .. bufdir_short .. "/" .. bufname .. modified
end

-- useful for cmdheight=0, shows in ruler with cmdheight=1
-- maybe show this as virtual text?
function statusline.search_count()
	if vim.v.hlsearch == 0 then
		return ""
	end
	local sc = vim.fn.searchcount()
	if sc.total == 0 then
		return ""
	end

	local search_history = vim.fn.execute "history search"
	local search_list = vim.split(search_history, "\n")
	local recent_search = search_list[#search_list]
	-- need to remove the numbers before the search pattern
	local _, finish = string.find(recent_search, "%d+ +")
	local result = string.sub(recent_search, finish + 1)

	return "['" .. result .. "' " .. sc.current .. "/" .. sc.total .. "]"
end

local components = {
	align = "%=",
	diag = "%{%v:lua.statusline.diag()%}",
	mode = "%{%v:lua.statusline.mode()%}",
	info = "%{%v:lua.statusline.info()%}  %*",
	position = "%{%v:lua.statusline.position()%}",
	truncate = "%<",
	centered_buffer = "%{%v:lua.statusline.centered_buffer()%}",
	buffer = "%{%v:lua.statusline.buffer()%}",
	lsp_status = "%{%v:lua.statusline.lsp_status()%}",
	search_count = "%{%v:lua.statusline.search_count()%}",
	version = "%{%v:lua.statusline.version()%}",
	lsp_progress = "%{%v:lua.statusline.lsp_progress()%}",
	git_branch = "%{%v:lua.statusline.git_branch()%}",
	git_info = "%{%v:lua.statusline.git_info()%}",
	filetype = "%{%v:lua.statusline.filetype()%}",
	lsp_action = "%{%v:lua.statusline.lsp_action()%}",

	mode_nc = "%{%v:lua.statusline.mode_nc()%}",
	buffer_nc = "%{%v:lua.statusline.buffer_nc()%}",
	position_nc = "%{%v:lua.statusline.position_nc()%}",
	lsp_status_nc = "%{%v:lua.statusline.lsp_status_nc()%}",
}

local status = table.concat {
	-- components.mode,
	components.buffer,
	" ",
	components.info,
	-- components.search_count,
	-- components.centered_buffer,
	"    ",
	components.align,
	components.truncate,
	-- components.lsp_action,
	" ",
	components.lsp_progress,
	" ",
	components.diag,
	components.lsp_status,
	components.position,
}

local status_nc = table.concat {
	-- components.mode_nc,
	components.buffer_nc,
	" ",
	components.info,
	-- components.search_count,
	-- components.centered_buffer,
	"    ",
	components.align,
	components.truncate,
	-- components.lsp_action,
	" ",
	-- components.lsp_progress,
	" ",
	components.diag,
	components.lsp_status_nc,
	components.position_nc,
}

function statusline.get()
	return vim.g.statusline_winid == vim.api.nvim_get_current_win() and status or status_nc
end

vim.go.statusline = "%!v:lua.statusline.get()"

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup("LspProgressMessage", { clear = true }),
	callback = function()
		vim.cmd "redrawstatus"
	end,
})

vim.opt.showmode = true
