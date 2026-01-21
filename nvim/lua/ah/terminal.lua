local M = {}

local state = {
	buf = -1,
	win = -1,
}

local create_window = function(opts)
	opts = opts or {}
	local direction = opts.split or "below"
	local is_vertical = direction == "left" or direction == "right"
	local size_key = is_vertical and "width" or "height"
	local size = is_vertical and math.floor(vim.o.columns * 0.45) or math.floor(vim.o.lines * 0.35)
	local relative = "editor" or ""
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config

	if opts.floating == true then
		win_config = {
			relative = relative,
			width = width,
			height = height,
			col = col,
			row = row,
		}
	else
		win_config = {
			split = direction,
			[size_key] = size,
		}
	end

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

M.toggle_terminal = function(opts)
	local cmd = opts.cmd or ""
	local direction = opts.direction or "below"
	local floating = opts.floating or false or ""

	if not vim.api.nvim_win_is_valid(state.win) then
		state = create_window { buf = state.buf, split = direction, floating = floating }
		if vim.bo[state.buf].buftype ~= "terminal" then
			vim.cmd("terminal " .. cmd)
			vim.cmd "startinsert"
		end
	else
		vim.api.nvim_win_hide(state.win)
	end
end

return M
