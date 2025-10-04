if not pcall(require, 'telescope') then
  return
end

local utils = require("plugins.configs.telescope.utils")
local map = vim.keymap.set

map("n", "<leader>sf", utils.find_files, { noremap = true, silent = true, desc = "Find files" })
map("n", "<leader>sw", utils.grep_string, { noremap = true, silent = true, desc = "Grep string" })
map("n", "<leader>sr", utils.oldfiles, { noremap = true, silent = true, desc = "Search recent files" })
map("n", "<leader>sg", utils.live_grep, { noremap = true, silent = true, desc = "Grep in current directory" })
map("n", "<leader>tl", utils.search_builtins, { noremap = true, silent = true, desc = "Search Neovim commands" })
map("n", "<leader>s=", utils.spell_check, { noremap = true, silent = true, desc = "Spell check" })
map("n", "<leader>sb", utils.search_buffers, { noremap = true, silent = true, desc = "Search open buffers" })
map("n", "<leader>sd", utils.search_diagnostics, { noremap = true, silent = true, desc = "Search diagnostics" })
map("n", "<leader>sh", utils.search_help, { noremap = true, silent = true, desc = "Search Nvim help" })
map("n", "<leader>sn", utils.search_notes, { noremap = true, silent = true, desc = "Search notes" })
map("n", "<leader>s/", utils.search_open_buffers, { noremap = true, silent = true, desc = "Search open buffers" })
map("n", "<leader>gn", utils.grep_notes, { noremap = true, silent = true, desc = "Grep in notes" })
map("n", "<leader>s.", utils.search_config, { noremap = true, silent = true, desc = "Search config" })
map("n", "<leader>g.", utils.grep_config, { noremap = true, silent = true, desc = "Grep in config" })
map("n", "<leader>vo", utils.vim_options, { noremap = true, silent = true, desc = "Options" })
map("n", "<leader>rm", utils.reload_module, { noremap = true, silent = true, desc = "Reload module" })
map("n", "<leader>/", utils.buffer_fuzzy_search, { noremap = true, silent = true, desc = "Grep current buffer" })
map("n", "<leader>:", utils.search_history, { noremap = true, silent = true, desc = "Command history" })
map("n", "<leader>sp", utils.search_projects_dir, { noremap = true, silent = true, desc = "Search projects" })
map("n", "<leader>fb", utils.file_browser, { noremap = true, silent = true, desc = "Browse files" })
map("n", "<leader>cs", utils.change_colourscheme, { noremap = true, silent = true, desc = "Change colourscheme" })
-- map("n", "<leader>tn", utils.notifications, { noremap = true, silent = true, desc = "List notifications" })
map("n", "<leader>tn", function()
  vim.cmd("Telescope notify theme=ivy layout_config={height=0.45}")
end, { noremap = true, silent = true, desc = "Notifications" })
