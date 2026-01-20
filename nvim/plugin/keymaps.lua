local map = vim.keymap.set
local term = require "ah.terminal"

map({ "n", "t" }, "<leader>tt", function()
	term.toggle_terminal {}
end)

map({ "n", "t" }, "<leader>vt", function()
	term.toggle_terminal { direction = "right" }
end)

map({ "n", "t" }, "<leader><leader>t", function()
	vim.cmd "tabnew"
	vim.cmd "term"
	vim.cmd "startinsert"
end)

map({ "n", "t" }, "<leader>ft", function()
	term.toggle_terminal { floating = true }
end)

map("n", "<leader>hh", function()
	vim.cmd("help " .. vim.fn.expand "<cword>")
end, { desc = "Help for current word" })

map("n", "<leader>so", "<cmd>source %<CR>")
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute current line" })
map("v", "<leader>x", ":lua<CR>", { desc = "execute current line" })

-- execute current file and send output to quickfix list
map("n", "<leader><leader>x", function()
	local result = vim.api.nvim_exec2("source %", { output = true })
	local output = result.output
	local split_lines = vim.split(output, "\n")
	vim.fn.setqflist({}, " ", {
		title = "Execute",
		lines = split_lines,
	})
	vim.cmd "copen"
	vim.cmd "normal G"
end)

-- break undo sequence on space, tab and enter
map("i", "<Space>", "<Space><C-g>u")
map("i", "<Tab>", "<Tab><C-g>u")
map("i", "<CR>", "<CR><C-g>u")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<M-h>", "<C-W>2<")
map("n", "<M-l>", "<C-W>2>")
map("n", "<M-j>", "<C-W>2-")
map("n", "<M-k>", "<C-W>2+")

map("t", "<M-h>", "<C-\\><C-n><C-W>2<i")
map("t", "<M-l>", "<C-\\><C-n><C-W>2>i")
map("t", "<M-j>", "<C-\\><C-n><C-W>2-i")
map("t", "<M-k>", "<C-\\><C-n><C-W>2+i")

-- replace word under cursor
map("n", "<C-w><C-r>", ":%s/<c-r><c-w>//g<left><left>")

-- navigate the quickfix list if it's open otherwise move the current line up and down
map({ "n", "t" }, "<M-C-j>", function()
	local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
	if qflist_id > 0 then
		pcall(vim.cmd, "cnext")
	else
		vim.cmd [[m .+1<CR>==]]
	end
end)

map({ "n", "t" }, "<M-C-k>", function()
	local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
	if qflist_id > 0 then
		pcall(vim.cmd, "cprev")
	else
		vim.cmd [[m .-2<CR>==]]
	end
end)

map("n", "<C-p>", "<C-^>")

map("n", "<CR>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd "nohlsearch"
	else
		vim.cmd "+"
	end
end)

map("n", "<leader><leader>c", "<cmd>copen<CR>")
map("n", "<leader><leader>q", "<cmd>cclose<CR>")

-- :h cmdline-editing

map({ "i", "c" }, "<C-b>", "<left>")
map({ "i", "c" }, "<C-f>", "<right>")
map({ "i", "c" }, "<C-a>", "<home>")
map("c", "<M-b>", "<S-left>")
map("c", "<M-f>", "<S-right>")

vim.keymap.set({ "i", "c" }, "<C-n>", "<Down>")
vim.keymap.set({ "i", "c" }, "<C-p>", "<Up>")

vim.keymap.set({ "t" }, "<C-n>", function()
	if vim.bo.filetype == "fzf" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "t", false)
		return ""
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true), "t", false)
		return ""
	end
end)

vim.keymap.set({ "t" }, "<C-p>", function()
	if vim.bo.filetype == "fzf" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true), "t", false)
		return ""
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "t", false)
		return ""
	end
end)

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

vim.keymap.set("n", "<leader>pp", function()
	require("ah.repl").send_repl_line()
end)

vim.keymap.set("n", "<leader>vv", function()
	require("ah.repl").send_repl_selection()
end)

vim.keymap.set("n", "<leader>vp", function()
	vim.cmd 'exe "normal vip \\<Esc>"'
	require("ah.repl").send_repl_selection()
end)

map("t", "<C-[><C-[>", "<C-\\><C-n>")

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- get cwd in the cmdline
map("c", "<C-d><C-w>", "<C-r>=getcwd()<CR><home>")
-- get path of the current file in cmdline
map("c", "<C-d><C-f>", "tcd <C-r>=expand('%:~:h')<CR>")

vim.keymap.set("n", "g??", function()
	vim.ui.open(("https://google.com/search?q=%s"):format(vim.fn.expand "<cword>"))
end)
vim.keymap.set("x", "g??", function()
	vim.ui.open(
		("https://google.com/search?q=%s"):format(
			vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() }), " "))
		)
	)
	vim.api.nvim_input "<esc>"
end)
