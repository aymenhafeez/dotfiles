if not pcall(require, 'telescope') then
  return
end

local utils = require("plugins.configs.telescope.utils")
local map = require("ah.utils").map
local opts = { noremap = true, silent = true }

map("<leader>sf", utils.find_files, "Find files")
map("<leader>sw", utils.grep_string, "Grep string")
map("<leader>sr", utils.oldfiles, "Search recent files")
map("<leader>sg", utils.live_grep, "Grep in current directory")
map("<leader>tl", utils.search_builtins, "Search Neovim commands")
map("<leader>s=", utils.spell_check, "Spell check")
map("<leader>sb", utils.search_buffers, "Search open buffers")
map("<leader>sd", utils.search_diagnostics, "Search diagnostics")
map("<leader>sh", utils.search_help, "Search Nvim help")
map("<leader>sn", utils.search_notes, "Search notes")
map("<leader>s/", utils.search_open_buffers, "Search open buffers")
map("<leader>gn", utils.grep_notes, "Grep in notes")
map("<leader>s.", utils.search_config, "Search config")
map("<leader>g.", utils.grep_config, "Grep in config")
map("<leader>vo", utils.vim_options, "Options")
map("<leader>rm", utils.reload_module, "Reload module")
map("<leader>/", utils.buffer_fuzzy_search, "Grep current buffer")
map("<leader>:", utils.search_history, "Command history")
map("<leader>sp", utils.search_projects_dir, "Search projects")
map("<leader>fb", utils.file_browser, "Browse files")
map("<leader>cs", utils.change_colourscheme, "Change colourscheme")
map("<leader>tn", function()
  vim.cmd("Telescope notify layout_config={width=0.8, height=0.85}")
end, "Notifications")
