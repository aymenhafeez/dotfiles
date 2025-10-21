local present, blink = pcall(require, "blink.cmp")
if not present then
  return
end

--- @module 'blink.cmp'
--- @type blink.cmp.Config
local options = {
  keymap = {
    preset = 'none',
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
    ['<C-j>'] = { 'hide', 'show_signature', 'hide_signature', 'fallback' },
    ['<C-h>'] = { 'cancel', 'fallback' },
    ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
    ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
    ['<C-y'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-e'] = { 'scroll_documentation_down', 'fallback' },
  },
  cmdline = {
    enabled = false,
    -- keymap = {
    --   preset = 'cmdline',
    --   ['<CR>'] = { 'select_accept_and_enter', 'fallback' },
    -- },
  },
  completion = {
    menu = {
      auto_show = true,
      auto_show_delay_ms = 0,
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 }
        },
        components = {
          kind = {
            text = function(ctx) return ctx.kind end,
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
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        }
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        max_width = 60,
        max_height = 15,
      }
    },
    ghost_text = {
      enabled = true,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
    providers = {
      lsp = { fallbacks = {} },
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  snippets = { preset = 'default' },
  fuzzy = { implementation = 'lua' },
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
    }
  },
}

blink.setup(options)

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})
