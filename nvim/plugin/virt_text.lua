---@diagnostic disable: param-type-mismatch
-- use nvim_buf_del_extmark() to remove the virtual text

local search_ns = vim.api.nvim_create_namespace "search:virttext"

local function clear_search_virttext()
	vim.api.nvim_buf_clear_namespace(0, search_ns, 0, -1)
end

local function update_search_virttext()
	local pattern = vim.fn.getreg "/"

	if pattern == "" then
		return
	end

	if vim.v.hlsearch ~= 1 then
		return
	end

	local ok, count = pcall(vim.fn.searchcount, { recompute = 1 })
	if not ok then
		return
	end

	clear_search_virttext()

	local virt_text = string.format("%d/%d", count.current, count.total)
	local line = vim.fn.line "." - 1

	vim.api.nvim_buf_set_extmark(0, search_ns, line, 0, {
		virt_text = { { virt_text, "DiagnosticVirtualTextOk" } },
		virt_text_pos = "eol",
	})
end

vim.keymap.set("n", "n", function()
	pcall(vim.cmd, "normal! n")
	update_search_virttext()
end)

vim.keymap.set("n", "N", function()
	pcall(vim.cmd, "normal! N")
	update_search_virttext()
end)

vim.keymap.set("n", "*", function()
	pcall(vim.cmd, "normal! *")
	update_search_virttext()
end)

vim.keymap.set("n", "#", function()
	pcall(vim.cmd, "normal! #")
	update_search_virttext()
end)

vim.keymap.set("n", "<CR>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd "nohlsearch"
		clear_search_virttext()
	else
		vim.cmd "+"
	end
end)
