-- plugin build hooks (:h vim.pack-events)
local function pack_hooks(ev)
  local name = ev.data.spec.name
  local kind = ev.data.kind

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
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.pack.add({
  "https://github.com/lervag/vimtex",
}, { load = false })

vim.cmd [[
colorscheme default-custom
set shortmess+=S
]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
vim.go.tabline = "%{%v:lua.require'tabline'.tabline()%}"

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    target = "msg",
  }
})

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
opt.showtabline = 2
opt.equalalways = false
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldmethod = "marker"
opt.completeopt = { "menu", "menuone", "popup", "noselect", "fuzzy" }
opt.wildmode = { "longest:full", "full" }
opt.complete = ".,o,w"
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
opt.pumheight = 12

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
  set_cursorline("FileType", false, { "help", "qf" })
end

-- show relative numbers only in Visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local mode = vim.fn.mode()

    if mode:match("[vV\22]") and vim.opt.number:get() == true then
      vim.opt.relativenumber = true
    else
      vim.opt.relativenumber = false
    end
  end,
})

vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions"
}

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

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function()
    vim.keymap.set("n", "q", "<C-w>c", { buffer = true })
  end
})
