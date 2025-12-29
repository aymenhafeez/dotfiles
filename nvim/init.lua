--         ________  ___  ___
--        |\   __  \|\  \|\  \
--        \ \  \|\  \ \  \\\  \      Aymen Hafeez
--         \ \   __  \ \   __  \     https://github.com/aymenhafeez
--          \ \  \ \  \ \  \ \  \    https://aymenhafeez.github.io
--           \|__|\|__|\|__|\|__|

if vim.g.neovide then
	vim.g.neovide_cursor_trail_legnth = 0
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_floating_corner_radius = 0.2
	vim.o.guifont = "Jetbrains Mono,nonicons:h10"
end

-- needs to go before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "ah/plugins" }, {
	change_detection = {
		notify = false,
	},
})
