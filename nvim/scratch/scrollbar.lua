local ns = vim.api.nvim_create_namespace "scrollbar"
local state = {}

local function on_win(_, winid, bufnr, topline, botline)
	if vim.api.nvim_win_get_config(winid).relative ~= "" then
		return false
	end

	local lines = vim.api.nvim_buf_line_count(bufnr)
	local height = vim.api.nvim_win_get_height(winid)

	if lines <= height then
		state[winid] = nil
	else
		local cells_per_line = height / lines
		local span = math.floor(0.5 + (botline - topline) * cells_per_line)
		local start = math.floor(topline + topline * cells_per_line)
		local end_ = math.min(lines, start + span + 1)
		state[winid] = { start = start, ["end"] = end_ }
	end

	vim.api.nvim__redraw { win = winid, valid = false }
	return state[winid] ~= nil
end

local function on_line(_, winid, bufnr, row)
	local win_state = state[winid]
	if win_state then
		local start = win_state.start
		local end_ = win_state["end"]
		if start <= row and row < end_ then
			vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
				ephemeral = true,
				virt_text = { { "▐", "NonText" } },
				virt_text_pos = "right_align",
				virt_text_repeat_linebreak = true,
			})
		end
	end
end

vim.api.nvim_set_decoration_provider(ns, { on_win = on_win, on_line = on_line })
