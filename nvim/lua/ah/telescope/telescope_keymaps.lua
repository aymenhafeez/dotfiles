local builtin = require "telescope.builtin"
local themes = require "telescope.themes"
local tele = require "ah.telescope"

vim.keymap.set("n", "<leader>gs", tele.git_status)
vim.keymap.set("n", "<leader>sf", tele.find_files)
vim.keymap.set("n", "<leader>sr", tele.oldfiles)
vim.keymap.set("n", "<leader>sh", tele.help_tags)
vim.keymap.set("n", "<leader>sD", tele.diagnostics)
vim.keymap.set("n", "<leader>ds", tele.lsp_document_symbols)

vim.keymap.set("n", "<leader>gf", tele.git_files)
vim.keymap.set("n", "<leader>s=", tele.spell_suggest)
vim.keymap.set("n", "<leader>/", tele.cur_buffer_search)
vim.keymap.set("n", "<leader>sb", tele.buffers)
vim.keymap.set("n", "<leader>sd", tele.buf_diagnostics)
vim.keymap.set("n", "<leader>sp", tele.search_projects)

vim.keymap.set("n", "<leader>g/", tele.grep_open_files)
vim.keymap.set("n", "<leader>sw", tele.grep_string)
vim.keymap.set("n", "<leader>gn", tele.grep_notes)
vim.keymap.set("n", "<leader>sg", tele.live_grep)
vim.keymap.set("n", "<leader>gl", tele.grep_plugins)
vim.keymap.set("n", "<leader>g.", tele.grep_config)

vim.keymap.set("n", "<leader>s.", tele.search_config)
vim.keymap.set("n", "<leader>sl", tele.search_plugins)
vim.keymap.set("n", "<leader>sn", tele.search_notes)

vim.keymap.set("n", "<leader>fb", tele.file_browser)
vim.keymap.set("n", "<leader>fn", tele.browse_notes)

vim.keymap.set("n", "<leader>tq", tele.search_quickfix)

vim.keymap.set("c", "<c-r><c-r>", tele.command_history)
