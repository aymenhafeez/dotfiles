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
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.pack.add({
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
}, { load = false })

vim.cmd [[
packadd nvim.undotree
packadd nvim.difftool
colorscheme nord
"hi link User1 DiagnosticError
set shortmess+=ScC
set sessionoptions-=blank

" :h restore-cursor
augroup RestoreCursor
  autocmd!
  autocmd BufReadPre * autocmd FileType <buffer> ++once
    \ let s:line = line("'\"")
    \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase'], &filetype) == -1
    \      && !&diff
    \ |   execute "normal! g`\""
    \ | endif
augroup END

" :h vim.hl.on_yank()
autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=150}
]]

vim.g.difftool_replace_diff_mode = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
    vim.go.tabline = "%{%v:lua.require'statusline'.tabline()%}"
  end
})

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    target = "msg",
  }
})

local opt = vim.opt

opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
opt.confirm = true
opt.conceallevel = 2
opt.cursorline = true
opt.cursorlineopt = "number"
vim.opt.cpoptions:remove { "_" }
opt.equalalways = false
opt.expandtab = true
opt.fillchars = "trunc:…"
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars:append("precedes:…,extends:…,trail:·")
opt.mouse = "nvc"
opt.number = true
opt.pumborder = "rounded"
opt.pumheight = 12
opt.pummaxwidth = 50
opt.scrolloff = 8
opt.shada = "'100,<50,s10,:1000,/100,@100,h"
opt.shiftwidth = 4
opt.showmatch = true
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = "en_gb"
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 300
opt.winborder = "rounded"
opt.wrap = false

opt.foldlevelstart = 99
opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
