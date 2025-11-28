local map = vim.keymap.set
local term = require "ah.terminal"

map({ "n", "t" }, "<leader>tt", function()
  term.toggle_terminal {}
end)
map({ "n", "t" }, "<leader>vt", function()
  term.toggle_terminal { direction = "right" }
end)

map({ "n", "t" }, "<leader><leader>t", function()
  term.toggle_terminal { floating = true }
end)

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

map({ "n", "t" }, "<M-j>", function()
  local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
  if qflist_id > 0 then
    pcall(vim.cmd, "cnext")
  else
    vim.cmd "resize -2"
  end
end)

map({ "n", "t" }, "<M-k>", function()
  local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
  if qflist_id > 0 then
    pcall(vim.cmd, "cprev")
  else
    vim.cmd "resize +2"
  end
end)

map("n", "<C-p>", "<C-^>")

map("n", "<leader>hl", "<cmd>nohlsearch<CR>")

map("n", "<leader><leader>c", "<cmd>copen<CR>")
map("n", "<leader><leader>q", "<cmd>cclose<CR>")

map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")

-- move visual selection up and down
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

map("v", "<", "<gv")
map("v", ">", ">gv")

-- move current line up and down
map("n", "<M-C-k>", function()
  vim.cmd [[m .-2<CR>==]]
end)
map("n", "<M-C-j>", function()
  vim.cmd [[m .+1<CR>==]]
end)

-- my keyboard doesn't have a backslash key
map({ "i", "c" }, "zx", "\\")
map({ "i", "c" }, "zc", "|")

map("c", "<C-n>", "<Down>")
map("c", "<C-p>", "<Up>")

map("n", "<leader>ps", function()
  local buf_nr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)

  vim.cmd "ScratchToggle"
  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
  print(buf_nr)
end)

map("n", "<leader>tf", function()
  if vim.bo.filetype == "lua" then
    return "<Plug>PlenaryTestFile"
  else
    return ""
  end
end, { expr = true })

map("t", "<C-[><C-[>", "<C-\\><C-n>")

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
