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
-- opt.expandtab = true
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
vim.opt.completeopt = { "menu", "menuone", "popup", "noinsert", "fuzzy" }
vim.o.complete = ".,o" -- use buffer and omnifunc
opt.scrolloff = 8
opt.sidescroll = 0

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.undofile = true
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
opt.winborder = "rounded"
opt.pumborder = "rounded"
opt.pumheight = 15
opt.cmdheight = 1

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- simplified lua implementation of cyclist.vim
opt.list = true
vim.opt.listchars = "tab:  ,nbsp:␣,extends:⋯,precedes:⋯,trail:·"
local listchars = {
	"tab:⊳ ,eol:↵,nbsp:␣,extends:⋯,precedes:⋯,trail:·",
	"tab:>-,eol:¬,nbsp:␣,extends:>,precedes:<,trail:-",
	"tab:>-,eol:↵,nbsp:␣,extends:>,precedes:<,trail:-",
	"tab:  ,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·",
	"tab:»·,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·",
	"tab:»·,eol:↲,nbsp:␣,extends:>,precedes:<,trail:·,space:␣",
	"",
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

-- -- only show winbar if laststatus = 3
-- if opt.laststatus:get() == 3 then
-- 	opt.winbar = "%=%f%m"
-- else
-- 	opt.winbar = ""
-- end

vim.cmd "colorscheme colourscheme"
