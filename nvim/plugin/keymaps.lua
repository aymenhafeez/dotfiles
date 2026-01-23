local map = vim.keymap.set

map("n", "<leader>hh", function()
	vim.cmd("help " .. vim.fn.expand "<cword>")
end, { desc = "Help for current word" })

map("n", "<leader>so", "<cmd>source %<CR>")
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute current line" })
map("v", "<leader>x", ":lua<CR>", { desc = "execute current line" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<M-h>", "<C-W>2<")
map("n", "<M-l>", "<C-W>2>")
map("n", "<M-j>", "<C-W>2-")
map("n", "<M-k>", "<C-W>2+")

-- replace word under cursor
map("n", "<C-w><C-r>", ":%s/<c-r><c-w>//g<left><left>")

map("n", "<C-p>", "<C-^>")

map("n", "<CR>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd "nohlsearch"
	else
		vim.cmd "+"
	end
end)

-- :h cmdline-editing
map({ "i", "c" }, "<C-b>", "<left>")
map({ "i", "c" }, "<C-f>", "<right>")
map({ "i", "c" }, "<C-a>", "<home>")
map("c", "<M-b>", "<S-left>")
map("c", "<M-f>", "<S-right>")

map("n", "<leader>nt", "<cmd>tabnew<CR>")
map({ "n", "t" }, "<leader>]", "<cmd>tabn<CR>")
map({ "n", "t" }, "<leader>[", "<cmd>tabp<CR>")

-- move visual selection up and down
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

map("v", "<", "<gv")
map("v", ">", ">gv")

-- search within visual selection
-- (https://www.reddit.com/r/neovim/comments/1kv7som/search_within_selection_in_neovim/)
map("x", "/", "<C-\\><C-n>`</\\%V\\(\\)<Left><Left>")
map("x", "?", "<C-\\><C-n>`>?\\%V\\(\\)<Left><Left>")

-- delete selection in selection mode
map("s", "<BS>", '<C-o>"_s')

-- my keyboard doesn't have a backslash key
map({ "i", "c", "t" }, "zx", "\\")
map({ "i", "c", "t" }, "zc", "|")

map("n", "<leader>ps", function()
	local buf_nr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)

	require("scratch").toggle { window_type = "float" }
	vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
end)

map("n", "<leader>tf", function()
	if vim.bo.filetype == "lua" then
		return "<Plug>PlenaryTestFile"
	else
		return ""
	end
end, { expr = true })

-- get cwd in the cmdline
map("c", "<C-d><C-w>", "<C-r>=getcwd()<CR><home>")
-- get path of the current file in cmdline
map("c", "<C-d><C-f>", "tcd <C-r>=expand('%:~:h')<CR>")

vim.keymap.set("n", "g??", function()
	vim.ui.open(("https://kagi.com/search?q=%s"):format(vim.fn.expand "<cword>"))
end)

vim.keymap.set("x", "g??", function()
	vim.ui.open(
		("https://kagi.com/search?q=%s"):format(
			vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() }), " "))
		)
	)
	vim.api.nvim_input "<esc>"
end)

vim.keymap.set("c", "<C-p>", function()
	if vim.fn.wildmenumode() ~= 0 then
		return "<C-p>"
	else
		return "<Up>"
	end
end, { expr = true })

vim.keymap.set("c", "<C-n>", function()
	if vim.fn.wildmenumode() ~= 0 then
		return "<C-n>"
	else
		return "<Down>"
	end
end, { expr = true })
