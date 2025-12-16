-- -- TODO: send commands/command output to a specific window
--
local on_exit = function(obj)
	print(obj.code)
	print(obj.signal)
	print(obj.stdout)
	print(obj.stderr)
end

vim.system({ "echo", "test" }, { text = true }, on_exit)

-- local input_tbl = {}
-- local tbl = vim.fn.input "Enter input: "
-- -- table.insert(input_tbl, tbl)
-- -- vim.print(input_tbl)
-- for w in tbl:gmatch "%S+" do
--   table.insert(input_tbl, w)
-- end
-- vim.print(input_tbl)

-- local bufnr = vim.api.nvim_get_current_buf()
local bufnr = 333

vim.keymap.set("n", "<leader>rp", function()
	local cmd = {}
	local opts = "source %"

	for w in opts:gmatch "%S+" do
		table.insert(cmd, w)
	end

	-- vim.print(cmd)
	vim.fn.execute(cmd)

	-- vim.fn.jobstart(cmd, {
	--   stdout_buffered = true,
	--   on_stdout = function(_, data)
	--     if data then
	--       vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
	--     end
	--   end,
	-- })
end)

local function cmd_repl(cmd)
	local buf = 333
	local lines = vim.fn.systemlist(cmd)

	if #lines > 0 then
		vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
	end
end

vim.keymap.set("n", "<leader>rl", function()
	cmd_repl(vim.fn.input "Command > ")
end)

local chans = vim.api.nvim_list_chans()
for _, chan in pairs(chans) do
	if chan.mode == "terminal" then
		local id = chan.id
		return id
	end
end

vim.print "did it work?"
