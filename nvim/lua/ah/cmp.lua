local present, blink = pcall(require, "blink.cmp")
if not present then
  return
end

--- @module 'blink.cmp'
--- @type blink.cmp.Config
local options = {
  keymap = {
    preset = "none",
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-k>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<C-j>"] = { "hide", "show_signature", "hide_signature", "fallback" },
    ["<C-h>"] = { "cancel", "fallback" },
    ["<C-u>"] = { "scroll_signature_up", "fallback" },
    ["<C-d>"] = { "scroll_signature_down", "fallback" },
    ["<C-y"] = { "scroll_documentation_up", "fallback" },
    ["<C-e"] = { "scroll_documentation_down", "fallback" },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<CR>"] = { "select_accept_and_enter", "fallback" },
    },
  },
  completion = {
    ghost_text = {
      enabled = true,
    },
    menu = {
      auto_show = true,
      auto_show_delay_ms = 0,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
          { "source_name", gap = 1 },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        max_width = 60,
        max_height = 15,
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "lazydev", "buffer" },
    providers = {
      lsp = { fallbacks = {} },
      lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },
  snippets = { preset = "luasnip" },
  fuzzy = { implementation = "lua" },
  signature = {
    enabled = true,
    trigger = {
      show_on_insert = true,
    },
    window = {
      show_documentation = true,
      max_width = 60,
      max_height = 15,
      scrollbar = true,
    },
  },
}

blink.setup(options)
