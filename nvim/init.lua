-- plugin build hooks (:h vim.pack-events)
local function pack_hooks(ev)
  local name = ev.data.spec.name
  local kind = ev.data.kind

  -- run :TSUpdate after install/update
  if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
      vim.cmd "TSUpdate"
    end
  end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_hooks })

vim.schedule(function()
  vim.pack.add({
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
  })

  vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
  vim.go.tabline = "%{%v:lua.require'statusline'.tabline()%}"
  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.opt.clipboard = "unnamedplus"
end)

vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"
vim.cmd.colorscheme "misterioso"

vim.g.difftool_replace_diff_mode = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = "cmd",
    pager = {
      height = 0.75
    }
  }
})

local opt = vim.opt

opt.breakindent = true
opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
opt.confirm = true
opt.conceallevel = 2
vim.opt.cpoptions:remove { "_" }
opt.equalalways = false
opt.expandtab = true
opt.fillchars = "trunc:…"
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars:append("precedes:…,extends:…,trail:ꞏ")
opt.mouse = "nvc"
opt.pumheight = 12
opt.pummaxwidth = 50
opt.scrolloff = 8
opt.shada = "'100,<50,s10,:1000,/100,@100,h"
opt.sessionoptions:remove { "blank" }
opt.shiftwidth = 4
opt.shortmess:append("Sc")
opt.showmatch = true
opt.showmode = false
-- opt.showtabline = 2
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = "en_gb"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 300
opt.wrap = false
