local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end
local colors = require("config.colors")

treesitter.setup {
  highlight = {
    enable = true,
    ensure_installed = "maintained",
    additional_vim_regex_highlighting = true,
    ignore_install = { "vim" },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
