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

" search in visual selection
cnoremap <expr> / (getcmdtype() =~ '[/?]' && getcmdline() == '') ? "\<C-C>\<Esc>/\\%V" : '/'
]]

local map = vim.keymap.set

map("n", "<leader>sh", ":help <C-z>")
map("n", "gK", "<cmd>help!<CR>")

map("n", "<leader>sb", ":b <C-z>")
map("n", "<leader>r", "<cmd>browse oldfiles<CR>")

map("n", "<leader>so", "<cmd>source %<CR>")
map("n", "<leader>x", "<cmd>.lua<CR>")
map("v", "<leader>x", ":lua<CR>")

map("n", "L", "<cmd>bnext<CR>")
map("n", "H", "<cmd>bprev<CR>")
map({ "n", "t" }, "<M-]>", "<cmd>tabn<CR>")
map({ "n", "t" }, "<M-[>", "<cmd>tabp<CR>")
map("n", "<M-t>", "<cmd>tab split<CR>")

map({ "n", "t" }, "<S-left>", "<C-\\><C-n><C-W>2<")
map({ "n", "t" }, "<S-right>", "<C-\\><C-n><C-W>2>")
map({ "n", "t" }, "<S-down>", "<C-\\><C-n><C-W>2-")
map({ "n", "t" }, "<S-up>", "<C-\\><C-n><C-W>2+")

map({ "n", "t" }, "<M-S-l>", "2zl")
map({ "n", "t" }, "<M-S-h>", "2zh")

map("n", "<C-e>", "3<C-e>")
map("n", "<C-y>", "3<C-y>")

map("n", "<S-Tab>", "<C-^>")

map({ "i", "c", "t" }, "<C-Backspace>", "<C-w>")
-- konsole sends ^backspace as ^H
map({ "i", "c" }, "<C-h>", "<C-w>")
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

map("n", "cdl", "<cmd>lcd %:h<bar>pwd<CR>")
map("n", "cdt", "<cmd>tcd %:h<bar>pwd<CR>")

map("c", "<C-p>", function()
  if vim.fn.wildmenumode() ~= 0 then
    return "<C-p>"
  else
    return "<Up>"
  end
end, { expr = true, desc = "Previous in wildmenu or history" })

map("c", "<C-n>", function()
  if vim.fn.wildmenumode() ~= 0 then
    return "<C-n>"
  else
    return "<Down>"
  end
end, { expr = true, desc = "Next in wildmenu or history" })

map("i", "<M-f>", "<C-Right>")
map("i", "<M-b>", "<C-Left>")

-- toggle window zoom
vim.keymap.set('n', '+', function()
  if vim.fn.winnr('$') == 1 then return end

  local prev = vim.fn.winrestcmd()
  vim.api.nvim_win_set_width(0, 9999)
  vim.api.nvim_win_set_height(0, 9999)

  if vim.t.zoom_restore then
    vim.cmd(vim.t.zoom_restore)
    vim.t.zoom_restore = nil
  elseif vim.fn.winrestcmd() ~= prev then
    vim.t.zoom_restore = prev
  end
end)

vim.api.nvim_create_user_command("Bdelete", function() require("bufclose").buf_delete() end, {})
vim.keymap.set("c", "bd", "Bdelete")
