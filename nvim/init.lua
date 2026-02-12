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
    vim.notify("Building LuaSnip jsregexp", vim.log.levels.INFO)
    local result = vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
    if result.code ~= 0 then
      vim.notify("LuaSnip build failed: " .. (result.stderr or ""), vim.log.levels.WARN)
    end
  end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.pack.add({
  "https://github.com/lervag/vimtex",
  "https://www.github.com/nvim-lua/plenary.nvim",
}, { load = false })

vim.cmd "colorscheme modus"

vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    local cmd = vim.fn.getcmdline()
    if cmd ~= "" then
      vim.g.last_cmdline = cmd
    end
  end,
})

vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
-- vim.go.tabline = "%{%v:lua.require'tabline'.tabline()%}"

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.g.last_cmdline = ""
  end,
})

-- experimental, :h vim._extui
require("vim._extui").enable({
  enable = true,
  msg = {
    ---@type 'cmd'|'msg' Where to place regular messages, either in the
    ---cmdline or in a separate ephemeral message window.
    target = "cmd",
    timeout = 4000,
  },
})

vim.cmd [[
command! -nargs=1 Ngrep vimgrep "<args>" /home/aymen/Documents/DataSci/**/*
nnoremap <Leader>[ :Ngrep
]]

local opt = vim.opt

opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.conceallevel = 2
opt.number = true
opt.signcolumn = "yes:1"
opt.wrap = false
opt.showmatch = true
opt.showcmdloc = "statusline"
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
opt.shada = "'100,<50,s10,:1000,/100,@100,h"
opt.inccommand = "split"
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

-- show search count and recording macro message in the statusline instead
vim.cmd("set shortmess+=Sq")

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

  set_cursorline({ "WinLeave", "InsertEnter" }, false)
  set_cursorline({ "WinEnter", "InsertLeave" }, true)
  set_cursorline("FileType", false, "help")
end

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.last_cmdline = ""

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<leader>hh", function()
  vim.cmd("help " .. vim.fn.expand "<cword>")
end, { desc = "Help for current word" })

map("n", "<leader>so", "<cmd>source %<CR>")
map("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute current line" })
map("v", "<leader>x", ":lua<CR>", { desc = "execute current line" })

map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

map("n", "L", "<cmd>bnext<CR>")
map("n", "H", "<cmd>bprev<CR>")
map("n", "<M-]>", "<cmd>tabn<CR>")
map("n", "<M-[>", "<cmd>tabp<CR>")

vim.keymap.set("n", "<M-h>", "<C-W>2<")
vim.keymap.set("n", "<M-l>", "<C-W>2>")
vim.keymap.set("n", "<M-j>", "<C-W>2-")
vim.keymap.set("n", "<M-k>", "<C-W>2+")

map("n", "<C-p>", "<C-^>")
map({ "i", "c", "t" }, "<C-Backspace>", "<C-w>")
map({ "i", "c", "t" }, "<C-w>", "")

-- :h cmdline-editing
vim.cmd [[
inoremap <C-A> <Home>
inoremap <C-F> <Right>
inoremap <C-B> <Left>
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
]]

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

map("i", "<CR>", function()
  if vim.fn.pumvisible() ~= 0 then
    return "<C-y>"
  else
    return "<CR>"
  end
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank {
      higroup = "Visual",
      timeout = 150,
    }
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("CursorPosition", {}),
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

local function open_help()
  local win_width = vim.api.nvim_win_get_width(0)
  if win_width > 160 then
    vim.cmd "wincmd L"
    vim.cmd "vertical resize -11"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  callback = open_help
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.txt",
  callback = function()
    if vim.bo.buftype == "help" then
      open_help()
    end
  end
})
