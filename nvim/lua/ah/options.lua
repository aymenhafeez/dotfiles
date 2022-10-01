local opt = vim.opt
local o = vim.o
local g = vim.g

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.conceallevel = 2
-- opt.concealcursor = "nc"
opt.laststatus = 3
opt.showtabline = 2
opt.cursorline = true
opt.showmode = false
opt.showcmd = false
opt.cmdheight = 1
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.linebreak = true

vim.opt.foldmethod = "expr" -- TreeSitter folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- TreeSitter folding
vim.opt.foldlevel = 6
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
}
vim.opt.foldtext = "getline(v:foldstart).'...'.trim(getline(v:foldend))"

-- cmdheight = 0 is a little buggy atm
if vim.fn.has("nvim-0.9") ~= 0 then
  vim.opt.cmdheight = 0
end

opt.formatoptions = vim.opt.formatoptions - "c"
opt.spelllang = "en_gb"
opt.shortmess:append "sI"

opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.undofile = true
opt.inccommand = "split"

opt.completeopt = { "menu", "menuone" }
opt.omnifunc = "syntaxcomplete#Complete"
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 10
opt.scrolloff = 5

opt.autochdir = true
opt.wildmenu = true
opt.wildoptions = "pum"

opt.autoread = true
opt.hidden = true
opt.ttimeoutlen = 0
opt.lazyredraw = true
opt.mouse = "nvia"
opt.clipboard = "unnamedplus"
opt.path:append { "**" }

opt.splitright = true

opt.termguicolors = true

o.winbar = "%{%v:lua.require'ah.winbar'.get_winbar()%}"

-- add `gf` functionality inside `.lua` files.
vim.opt_local.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"

for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  vim.opt_local.path:append(path .. '/lua')
end

vim.opt_local.suffixesadd:prepend('.lua')

g.UltiSnipsExpandTrigger = "<tab>"
g.UltiSnipsJumpForwardTrigger = "<tab>"
g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

g.scratch_filetype = "lua"

g.floaterm_wintype = "split"
g.floaterm_height = 13
g.floaterm_position = "rightbelow"
g.floaterm_borderchars = "─│─│╭╮╯╰"

-- use proper syntax highlighting in code blocks
local fences = {
  "lua",
  "vim",
  "json",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
vim.g.markdown_fenced_languages = fences

vim.cmd [[
let g:OxfDictionary#app_id="ed82927e"
let g:OxfDictionary#app_key="97ed8b2daccd553e7f62a3aebdbdc492"
]]

local builtin_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(builtin_plugins) do
  g["loaded_" .. plugin] = 1
end

vim.cmd("au FocusGained * :checktime")

local colorscheme = "tokyonight-night"

if colorscheme == "onedark" then
  require("onedark").setup({
    style = "deep"
  })
end

if colorscheme == "catppuccin" then
  vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
