local function get_mini_icon(ctx)
  if ctx.source_name == "Path" then
    local is_unknown_type = vim.tbl_contains(
      { "link", "socket", "fifo", "char", "block", "unknown" },
      ctx.item.data.type
    )
    local mini_icon, mini_hl, _ = require("mini.icons").get(
      is_unknown_type and "os" or ctx.item.data.type,
      is_unknown_type and "" or ctx.label
    )
    if mini_icon then
      return mini_icon, mini_hl
    end
  end
  local mini_icon, mini_hl, _ = require("mini.icons").get("lsp", ctx.kind)
  mini_icon = " " .. mini_icon
  return mini_icon, mini_hl
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
        -- components = {
        --   kind_icon = {
        --     text = function(ctx) return " " .. ctx.kind_icon .. ctx.icon_gap end
        --   }
        -- },
        components = {
          kind_icon = {
            text = function(ctx)
              local kind_icon, kind_hl = get_mini_icon(ctx)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl = get_mini_icon(ctx)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl = get_mini_icon(ctx)
              return hl
            end,
          }
        }
      }
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
      show_documentation = false,
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
      { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
      -- "https://github.com/edisj/msgarea.nvim"
    }, { load = false })

    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.setup(options)
    else
      vim.notify("Failed to load blink.cmp: " .. tostring(blink), vim.log.levels.ERROR)
    end

    -- vim.g.msgarea_max_height = 12
    -- require("msgarea.blink_integration").enable()
    -- vim.keymap.set("n", "<M-n>", function() require("msgarea").close_all() end)
  end
})
