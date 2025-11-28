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
    ["<C-y>"] = { "scroll_documentation_up", "fallback" },
    ["<C-e>"] = { "scroll_documentation_down", "fallback" },
  },
  cmdline = {
    enabled = true,
    keymap = {
      preset = "cmdline",
      ["<CR>"] = { "select_accept_and_enter", "fallback" },
    },
    completion = {
      menu = {
        auto_show = true,
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
  completion = {
    trigger = {
      show_on_insert = false,
      show_on_backspace_in_keyword = true,
    },
    ghost_text = {
      enabled = false,
    },
    menu = {
      winblend = 10,
      auto_show = true,
      auto_show_delay_ms = 0,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 },
          { "source_name", gap = 1 },
        },
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
          label = {
            width = { max = 40 },
          },
          source_name = {
            text = function(ctx)
              return "[" .. ctx.source_name .. "]"
            end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        winblend = 10,
        max_width = 60,
        max_height = 20,
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "lazydev", "buffer" },
    providers = {
      cmdline = {
        min_keyword_length = function(ctx)
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 3
          end
          return 0
        end,
      },
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
      max_height = 20,
      winblend = 10,
      scrollbar = false,
    },
  },
}

blink.setup(options)
