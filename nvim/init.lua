local opt = vim.opt

-- plugin build hooks (:h vim.pack-events)
local function pack_hooks(ev)
  local name = ev.data.spec.name
  local kind = ev.data.kind
  local path = ev.data.path

  -- run :TSUpdate after install/update
  if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
    if not ev.data.active then
      vim.cmd.packadd("nvim-treesitter")
      vim.cmd "TSUpdate"
    end
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

vim.schedule(function()
  vim.pack.add({
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
  })

  vim.go.statusline = "%{%v:lua.require'statusline'.statusline()%}"
  -- vim.go.tabline = "%{%v:lua.require'tabline'.tabline()%}"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  opt.clipboard = "unnamedplus"
end)

vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"
-- vim.cmd.colorscheme "vim_default"
vim.cmd.colorscheme(vim.o.background == "dark" and "vim_default" or "adwaita")

vim.g.difftool_replace_diff_mode = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = "msg",
  }
})

opt.breakindent = true
opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
opt.confirm = true
opt.conceallevel = 2
opt.cursorline = true
opt.cpoptions:remove { "_" }
opt.equalalways = false
opt.expandtab = true
vim.opt.fillchars = {
  trunc = "…",
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldinner = " ",
  foldsep = " ",
  eob = "*",
}
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldtext = ""
-- opt.foldcolumn = "auto"
opt.ignorecase = true
opt.inccommand = "split"
opt.list = true
opt.listchars:append("precedes:…,extends:…,trail:ꞏ")
opt.mouse = "nvc"
-- opt.pumborder = "rounded"
opt.pumheight = 12
opt.pummaxwidth = 50
opt.scrolloff = 8
opt.shada = "'100,<50,s10,:1000,/100,@100,h"
opt.sessionoptions:remove { "blank" }
opt.shiftwidth = 4
opt.showcmdloc = "statusline"
-- opt.showtabline = 2
opt.shortmess:append("Ssc")
opt.showmatch = true
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
-- opt.winborder = "rounded"
opt.wrap = false
