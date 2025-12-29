--[[
Look into:
  * getcharsearch() (maybe useful, not sure)
  * searchpos({pattern}) <- moves to next search position of {pattern} as well
  * search()
  * look at Telescope search_history to get the most recent search
  * pass the current most search to searchpos()
--]]

-- local function search_count()
-- 	local tbl = {}
-- 	local count = vim.fn.searchcount { recompute = 1 }
-- 	return count.current .. "/" .. count.total
-- end
--
-- P(search_count())
--
-- local ns = vim.api.nvim_create_namespace "test:virttext"
--
-- vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
--
-- local line = vim.fn.line "."
-- local offset = 3
-- local col = vim.fn.col "."
--
-- vim.api.nvim_buf_set_extmark(0, ns, line - 1, 0, {
-- 	virt_text = { { tostring(search_count()), "Comment" } },
-- 	virt_text_pos = "eol_right_align",
-- })
--
-- vim.api.nvim_create_autocmd("SearchWrapped", {
-- 	group = vim.api.nvim_create_augroup("VirtualText", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		local count = vim.fn.searchcount { recompute = 1 }
-- 		local search_ns = vim.api.nvim_create_namespace "search:virttext"
-- 		vim.api.nvim_buf_clear_namespace(0, search_ns, 0, -1)
-- 		local lines = vim.fn.line "."
-- 		vim.api.nvim_buf_set_extmark(0, search_ns, lines, 0, {
-- 			virt_text = { { tostring(count.current .. "/" .. count.total) } },
-- 			virt_text_pos = "eol_right_align",
-- 		})
-- 	end,
-- })

-- local search_history = vim.fn.execute "history search"
-- local search_list = vim.split(search_history, "\n")
-- local recent_search = search_list[#search_list]
-- -- need to remove the numbers before the search pattern
-- local _, finish = string.find(recent_search, "%d+ +")
-- local result = string.sub(recent_search, finish + 1)

local count = vim.fn.searchcount { recompute = 1 }
local search_ns = vim.api.nvim_create_namespace "search:virttext"

-- get the most recent search pattern
local search_virttext = function()
	local result = vim.fn.getreg "/"
	local search_pos_linenr = vim.fn.searchpos(result)[1]

	print(result)
	vim.print(search_pos_linenr)

	local bufnr = vim.api.nvim_get_current_buf()
	vim.api.nvim_buf_clear_namespace(bufnr, search_ns, 0, -1)

	if vim.v.hlsearch and vim.v.hlsearch == 1 then
		vim.api.nvim_buf_set_extmark(0, search_ns, search_pos_linenr - 1, 0, {
			virt_text = { { result .. " " .. tostring(count.current .. "/" .. count.total) } },
			virt_text_pos = "eol_right_align",
		})
	end
end

-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = vim.api.nvim_create_augroup("SearchVirtText", { clear = true }),
-- 	callback = function()
-- 		search_virttext()
-- 	end,
-- })

vim.keymap.set("n", "n", function()
	search_virttext()
end)
