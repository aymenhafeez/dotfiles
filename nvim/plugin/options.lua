local opt = vim.opt

local builtin_plugins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
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
opt.laststatus = 3
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.undofile = true
opt.inccommand = "split"

opt.winborder = "rounded"

opt.formatoptions:remove { "c" }
opt.spelllang = "en_gb"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.termguicolors = true
opt.confirm = true
opt.autochdir = false

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

vim.cmd "colorscheme gruvbuddy"
