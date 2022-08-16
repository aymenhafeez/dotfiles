local opts = { noremap = true, silent = true }
local nopts = { noremap = true, silent = false }
local term_opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- insert mode

map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", opts)

map("i", "<Space>", "<Space><C-g>u", opts)
map("i", "<Tab>", "<Tab><C-g>u", opts)
map("i", "<CR>", "<CR><C-g>u", opts)

-- command line mode

map("c", "<C-b>", "<Left>", opts)
map("c", "<C-f>", "<Right>", opts)
map("c", "<Esc>b", "<S-Left>", opts)
map("c", "<Esc>f", "<S-Right>", opts)
map("c", "<C-p>", "<Up>", opts)
map("c", "<C-n>", "<Down>", opts)

-- normal mode

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

map("n", "<leader>spl", ":setlocal spell!<CR>", opts)

map("n", "<leader>so", ":source %<CR>", opts)

map("n", "<S-Up>", ":resize +2<CR>", opts)
map("n", "<S-Down>", ":resize -2<CR>", opts)
map("n", "<S-Left>", ":vertical resize -2<CR>", opts)
map("n", "<S-Right>", ":vertical resize +2<CR>", opts)

map("n", "<leader>b", ":buffer <C-z><C-p>", nopts)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

map("n", "<C-s>", "mm[s1z=`m", opts)

map("n", "<C-n>", ":cnext<CR>", opts)
map("n", "<C-p>", ":cprev<CR>", opts)
map("n", "<C-c><C-l>", ":ccl<CR>", opts)

map("n", "<leader>hh", "yiw:help <C-r>\"<CR>", opts)

map("n", "<leader>mm", ":message<CR>", nopts)

-- plugin mappings

map("n", "<leader>-", ":NvimTreeToggle<CR>", opts)

map("n", "<leader>tt", ":FloatermToggle<CR>", opts)
map("t", "<leader>tt", "<C-\\><C-n>:FloatermToggle<CR>", opts)

map("n", "<leader>sc", ":Scratch<CR>", opts)
map("n", "<leader>ss", ":Sscratch<CR>", opts)

map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>rr', ':Telescope live_grep<CR>', opts)

-- visual mode

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

map("v", "<leader>so", "\"ay:<C-r>a<Backspace><CR>", opts)

map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

map("v", "<leader>hh", "y:help <C-r>\"<CR>", opts)

-- terminal

map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- misc commands

vim.cmd [[
    command! -nargs=1 Search vimgrep <args> ~/Dropbox/notes/MyNotes/**/*.{tex,md}
]]
map("n", "<leader>[", ":Search ", nopts)

vim.cmd [[
    cnoreabbrev bd Bd
]]
