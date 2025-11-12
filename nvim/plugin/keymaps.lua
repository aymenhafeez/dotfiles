local map = vim.keymap.set

map({ "n", "t" }, "<leader>tt", "<cmd>TermTog<CR>")
map({ "n", "t" }, "<leader>vt", "<cmd>TermTog right<CR>")

map("n", "<leader>ft", "<cmd>FloatTerm<CR>")
map("n", "<leader>lg", "<cmd>FloatTerm(lazygit)<CR>")
map("n", "<leader>ht", "<cmd>FloatTerm(htop)<CR>")

map("n", "<leader>hh", function()
  vim.cmd("help " .. vim.fn.expand "<cword>")
end, { desc = "Help for current word" })

map("n", "<leader>so", "<cmd>source %<CR>")

map("n", "<leader><leader>x", "<cmd>.lua<CR>", { desc = "Execute current line" })

map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<S-h>", "<cmd>bprev<CR>")

map({ "n", "t" }, "<leader><C-l>", "<cmd>tabn<CR>")
map({ "n", "t" }, "<leader><C-h>", "<cmd>tabN<CR>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<M-k>", "<C-W>2+")
map("n", "<M-j>", "<C-W>2-")
map("n", "<M-h>", "<C-W>2<")
map("n", "<M-l>", "<C-W>2>")

map("n", "<C-p>", "<cmd>e #<CR>")

map("n", "<leader><leader>s", "<cmd>setlocal spell!<CR>")
map("n", "<C-s>", "mm[s1z=`m", { desc = "Correct previous spelling error" })
map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { desc = "Correct previous spelling error" })

map("n", "<leader>hl", "<cmd>nohlsearch<CR>")

map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
map({ "i", "c" }, "<C-b>", "<Left>")
map({ "i", "c" }, "<C-f>", "<Right>")
map({ "i", "c" }, "<M-b>", "<S-Left>")
map({ "i", "c" }, "<M-f>", "<S-Right>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

map("t", "<C-[><C-[>", "<C-\\><C-n>")

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- my keyboard doesn't have a backslash key
map({ "i", "c" }, "zx", "\\")
