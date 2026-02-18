vim.cmd [[
" :h cmdline-editing
inoremap <C-A> <Home>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

command! -nargs=1 Ngrep vimgrep "<args>" **/*
nnoremap <Leader>[ :Ngrep

autocmd CmdlineChanged [:\/\?] call wildtrigger()
set wildmode=noselect:lastused,full
set wildoptions=pum,tagfile,fuzzy

" :h fuzzy-file-picker
set findfunc=Find
func Find(arg, _)
  if empty(s:filescache)
    let s:filescache = globpath('.', '**', 1, 1)
    call filter(s:filescache, '!isdirectory(v:val)')
    call map(s:filescache, "fnamemodify(v:val, ':.')")
  endif
  return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
autocmd CmdlineEnter : let s:filescache = []

nnoremap <leader>f :find<space>
]]

local map = vim.keymap.set

map("n", "<leader>hh", function()
  vim.cmd("help " .. vim.fn.expand "<cword>")
end)

map("n", "<leader>sb", ":b <C-z>")

map("n", "<leader>so", "<cmd>source %<CR>")
map("n", "<leader>x", "<cmd>.lua<CR>")
map("v", "<leader>x", ":lua<CR>")

-- map({ "n", "t" }, "<C-h>", "<C-\\><C-n><C-w><C-h>")
-- map({ "n", "t" }, "<C-j>", "<C-\\><C-n><C-w><C-j>")
-- map({ "n", "t" }, "<C-k>", "<C-\\><C-n><C-w><C-k>")
-- map({ "n", "t" }, "<C-l>", "<C-\\><C-n><C-w><C-l>")

vim.keymap.set({ "n", "t" }, "<C-h>", require("nvim-tmux-navigation").NvimTmuxNavigateLeft)
vim.keymap.set({ "n", "t" }, "<C-j>", require("nvim-tmux-navigation").NvimTmuxNavigateDown)
vim.keymap.set({ "n", "t" }, "<C-k>", require("nvim-tmux-navigation").NvimTmuxNavigateUp)
vim.keymap.set({ "n", "t" }, "<C-l>", require("nvim-tmux-navigation").NvimTmuxNavigateRight)
vim.keymap.set({ "n", "t" }, "<C-\\>", require("nvim-tmux-navigation").NvimTmuxNavigateLastActive)
vim.keymap.set({ "n", "t" }, "<C-Space>", require("nvim-tmux-navigation").NvimTmuxNavigateNext)

map("n", "L", "<cmd>bnext<CR>")
map("n", "H", "<cmd>bprev<CR>")
map({ "n", "t" }, "<M-]>", "<cmd>tabn<CR>")
map({ "n", "t" }, "<M-[>", "<cmd>tabp<CR>")
map("n", "<M-t>", "<cmd>tab split<CR>")

map("n", "<M-h>", "<C-W>2<")
map("n", "<M-l>", "<C-W>2>")
map("n", "<M-j>", "<C-W>2-")
map("n", "<M-k>", "<C-W>2+")

map("n", "<Tab>", "<C-^>")

map({ "i", "c", "t" }, "<C-Backspace>", "<C-w>")
map({ "i", "c", "t" }, "<C-w>", "")

map("n", ";nt", "<cmd>tabnew<CR>")

-- move visual selection up and down
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

map("v", "<", "<gv")
map("v", ">", ">gv")

-- delete selection in selection mode
map("s", "<BS>", '<C-o>"_s')

-- my keyboard doesn't have a backslash key
map({ "i", "c", "t" }, "zx", "\\")
map({ "i", "c", "t" }, "zc", "|")

-- get path of the current file in cmdline
map("c", "<C-d><C-f>", "tcd <C-r>=expand('%:~:h')<CR>")

map("c", "<C-p>", function()
  if vim.fn.wildmenumode() ~= 0 then
    return "<C-p>"
  else
    return "<Up>"
  end
end, { expr = true })

map("c", "<C-n>", function()
  if vim.fn.wildmenumode() ~= 0 then
    return "<C-n>"
  else
    return "<Down>"
  end
end, { expr = true })

map("c", "<C-j>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<Down><Tab>"
  else
    return "<C-j>"
  end
end, { expr = true })

map("c", "<C-k>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<Up><Tab>"
  else
    return "<C-k>"
  end
end, { expr = true })

map("i", "<CR>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-y>"
  else
    return "<CR>"
  end
end, { expr = true })
