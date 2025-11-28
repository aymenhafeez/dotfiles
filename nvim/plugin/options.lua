local opt = vim.opt

local builtin_plugins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
}
for _, plugin in pairs(builtin_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

opt.smartindent = true
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.conceallevel = 2

-- only show cursorline in current window
opt.cursorline = true
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
set_cursorline("FileType", false, "TelescopePrompt")

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.wrap = false
opt.scrolloff = 8
opt.showmode = false

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.undofile = true
opt.inccommand = "split"

opt.formatoptions:remove { "c" }
opt.spelllang = "en_gb"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.confirm = true
opt.autochdir = false

opt.winblend = 10
opt.pumblend = 10

opt.list = true
local listchars = {
  "tab:>-,eol:¬,nbsp:␣,extends:…,precedes:<,extends:>,trail:-",
  "tab:>-,eol:↵,nbsp:␣,extends:…,precedes:<,extends:>,trail:-",
  "tab:  ,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·",
  "tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·",
  "tab:»·,eol:↲,nbsp:␣,extends:…,precedes:<,extends:>,trail:·,space:␣",
  "",
}
local listchar_index = 1
local cycle_listchars = function()
  listchar_index = listchar_index % #listchars + 1
  vim.opt.listchars = listchars[listchar_index]
end

vim.keymap.set("n", "<leader>cl", function()
  cycle_listchars()
end)

-- lua file navigation
opt.include = [[\v<((do|load)file|require)[^''"]*[''"]\zs[^''"]+]]
opt.includeexpr = "substitute(v:fname,'\\.','/','g')"
for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
  opt.path:append(path .. "/lua")
end
opt.suffixesadd:prepend ".lua"

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local fences = { "lua", "vim", "json", "shell=sh", "python", "sh", "console=sh" }
vim.g.markdown_fenced_languages = fences

vim.cmd "colorscheme colourscheme"
