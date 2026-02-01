-- plugin build hooks (:h vim.pack-events)
local function pack_hooks(ev)
  local name = ev.data.spec.name
  local kind = ev.data.kind
  local path = ev.data.path
  -- run :TSUpdate after install/update
  if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.schedule(function()
      local ok, err = pcall(vim.cmd, "TSUpdate")
      if not ok then
        vim.notify("TSUpdate failed: " .. tostring(err), vim.log.levels.WARN)
      end
    end)
  end

  -- build jsregexp for LuaSnip
  if name == "LuaSnip" and (kind == "install" or kind == "update") then
    vim.notify("Building LuaSnip jsregexp...", vim.log.levels.INFO)
    local result = vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
    if result.code ~= 0 then
      vim.notify("LuaSnip build failed: " .. (result.stderr or ""), vim.log.levels.WARN)
    end
  end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.pack.add({
  "https://github.com/lervag/vimtex",
}, { load = false })

vim.cmd "colorscheme colourscheme"

-- experimental, :h vim._extui
require("vim._extui").enable({
  enable = true,
  msg = {
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    ---cmdline or in a separate ephemeral message window.
    target = "msg",
    timeout = 4000,
  },
})

local opt = vim.opt

opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.conceallevel = 2

-- only show the cursorline in the active window
opt.cursorline = true
if vim.opt.cursorline:get() == true then
  local group = vim.api.nvim_create_augroup("CursorLineCurrentWindow", { clear = true })
  local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
      group = group,
      pattern = pattern,
      callback = function()
        vim.opt_local.cursorline = value
      end,
    })
  end

  set_cursorline("WinLeave", false)
  set_cursorline("WinEnter", true)
end

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.wrap = false
opt.showmatch = true
opt.equalalways = false
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "marker"
opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
opt.wildmode = { "longest:full", "full" }
opt.complete = ".,o"
opt.scrolloff = 8
opt.sidescroll = 0
opt.updatetime = 300

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.undofile = true
opt.inccommand = "split"

opt.showmode = false
opt.formatoptions:append { "tcqj" }
opt.spelllang = "en_gb"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.confirm = true
opt.autochdir = false
opt.mouse = "nvc"
opt.cedit = "^C"
opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.pumheight = 15

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- simplified lua implementation of cyclist.vim
opt.list = true
opt.listchars = { tab = "  ", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" }
local listchars = {
  { tab = "⊳ ", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  { tab = ">-", eol = "¬", nbsp = "␣", extends = ">", precedes = "<", trail = "-" },
  { tab = ">-", eol = "↵", nbsp = "␣", extends = ">", precedes = "<", trail = "-" },
  { tab = "  ", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  { tab = "  ", eol = "↲", nbsp = "␣", extends = ">", precedes = "<", trail = "·" },
  { tab = "»·", eol = "↲", nbsp = "␣", extends = "⋯", precedes = "⋯", trail = "·" },
  {},
}
local listchar_index = 1
local cyclelist_chars = function()
  listchar_index = listchar_index % #listchars + 1
  vim.opt.listchars = listchars[listchar_index]
end

vim.keymap.set("n", "<leader>cl", function()
  cyclelist_chars()
end)

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
vim.go.tabline = "%{%v:lua.require'statusline'.tabline()%}"

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

-- substitute in selection
vim.keymap.set("x", "ms", ":s//<left>")
-- substitute all lines starting with given pattern
vim.keymap.set("x", "ml", ":s/^.*/<left><left><left>")

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

-- get cwd in the cmdline
map("c", "<C-d><C-w>", "<C-r>=getcwd()<CR><home>")
-- get path of the current file in cmdline
map("c", "<C-d><C-f>", "tcd <C-r>=expand('%:~:h')<CR>")

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
