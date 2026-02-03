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
    ["<C-y>"] = { "accept", "fallback" },
    ["<M-l>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<CR>"] = { "accept_and_enter", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<Tab>"] = { "show", "fallback_to_mappings" },
      ["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
  },
  completion = {
    trigger = {
      show_on_blocked_trigger_characters = {},
    },
    ghost_text = {
      enabled = true,
    },
    menu = {
      auto_show = true,
      winblend = 0,
      max_height = 15,
      draw = {
        align_to = "label",
        padding = { 0, 1 },
        columns = {
          { "kind_icon",   gap = 1 },
          { "label",       "label_description", gap = 1 },
          { "source_name", gap = 1 },
        },
        components = {
          kind_icon = {
            text = function(ctx) return " " .. ctx.kind_icon .. ctx.icon_gap .. "  " end
          }
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 50,
      window = {
        winblend = 0,
        max_width = 75,
        max_height = 20,
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = { fallbacks = {} },
    },
  },
  snippets = { preset = "luasnip" },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = {
    enabled = true,
    trigger = {
      enabled = true,
      show_on_keyword = false,
      show_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
    },
    window = {
      show_documentation = true,
      winblend = 0,
      max_width = 75,
      max_height = 20,
      scrollbar = false,
    },
  },
}

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.pack.add({
      { src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
    }, { load = false })

    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.setup(options)
    else
      vim.notify("Failed to load blink.cmp: " .. tostring(blink), vim.log.levels.ERROR)
    end
  end
})
