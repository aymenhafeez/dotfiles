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

" search in visual selection
cnoremap <expr> / (getcmdtype() =~ '[/?]' && getcmdline() == '') ? "\<C-C>\<Esc>/\\%V" : '/'
]]

local map = vim.keymap.set

map("n", "<leader>h", ":help <C-z>")
map("n", "<leader><leader>h", function()
  vim.cmd("help " .. vim.fn.expand "<cword>")
end, { desc = "Open help for word under cursor" })

map("n", "<leader>b", ":b <C-z>", { desc = "Switch to buffer" })
map("n", "<leader>r", "<cmd>browse oldfiles<CR>", { desc = "Recent files" })

map("n", "<leader>so", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute current line" })
map("v", "<leader>x", ":lua<CR>", { desc = "Execute selection" })

map("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "H", "<cmd>bprev<CR>", { desc = "Previous buffer" })
map({ "n", "t" }, "<M-]>", "<cmd>tabn<CR>", { desc = "Next tab" })
map({ "n", "t" }, "<M-[>", "<cmd>tabp<CR>", { desc = "Previous tab" })
map("n", "<M-t>", "<cmd>tab split<CR>", { desc = "Open buffer in new tab" })

map({ "n", "t" }, "<M-h>", "<C-\\><C-n><C-W>2<", { desc = "Decrease window width" })
map({ "n", "t" }, "<M-l>", "<C-\\><C-n><C-W>2>", { desc = "Increase window width" })
map({ "n", "t" }, "<M-j>", "<C-\\><C-n><C-W>2-", { desc = "Decrease window height" })
map({ "n", "t" }, "<M-k>", "<C-\\><C-n><C-W>2+", { desc = "Increase window height" })

map({ "n", "t" }, "<M-S-l>", "2zl", { desc = "Scroll horizontally right" })
map({ "n", "t" }, "<M-S-h>", "2zh", { desc = "Scroll horizontally left" })

map("n", "<Tab>", "<C-^>", { desc = "Switch to alternate buffer" })

map({ "i", "c", "t" }, "<C-Backspace>", "<C-w>", { desc = "Delete word backwards" })
map({ "i", "c", "t" }, "<C-w>", "", { desc = "Disable default Ctrl-w" })

map("n", ";nt", "<cmd>tabnew<CR>", { desc = "Create new tab" })

-- move visual selection up and down
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- delete selection in selection mode
map("s", "<BS>", '<C-o>"_s', { desc = "Delete selection" })

-- my keyboard doesn't have a backslash key
map({ "i", "c", "t" }, "zx", "\\", { desc = "Insert backslash" })
map({ "i", "c", "t" }, "zc", "|", { desc = "Insert pipe" })

map("n", "cdl", "<cmd>lcd %:h<bar>pwd<CR>", { desc = "Change local dir to current file" })
map("n", "cdt", "<cmd>tcd %:h<bar>pwd<CR>", { desc = "Change tab dir to current file" })

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

vim.keymap.set("i", "<CR>", function()
  local key = vim.keycode('<CR>')
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-y>")
  end
  vim.api.nvim_feedkeys(key, 'n', false)
end)

map("i", "<C-e>", function()
  if vim.fn.pumvisible() == 0 then
    return "<End>"
  else
    return "<C-e>"
  end
end, { expr = true, desc = "Accept completion or insert newline" })

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
end, { desc = "Toggle window zoom" })

vim.api.nvim_create_user_command("Bdelete", function() require("bufclose").buf_delete() end, {})
vim.keymap.set("c", "bd", "Bdelete", { desc = "Smart buffer delete" })

vim.keymap.set("n", "<leader>a", function()
  vim.cmd "argadd %"
  vim.cmd "argdedupe"
end, { desc = "Add buffer args list" })

vim.keymap.set("n", "<leader>e", function()
  vim.cmd.args()
end, { desc = "Show args list" })

vim.keymap.set("n", "<leader>1", function()
  vim.cmd("1argument")
end, { desc = "Go to arg 1" })
vim.keymap.set("n", "<leader>2", function()
  vim.cmd("2argument")
end, { desc = "Go to arg 2" })
vim.keymap.set("n", "<leader>3", function()
  vim.cmd("3argument")
end, { desc = "Go to arg 3" })
vim.keymap.set("n", "<leader>4", function()
  vim.cmd("4argument")
end, { desc = "Go to arg 4" })
