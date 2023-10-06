local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local icons = require("ah.utils").icons
local border = require("ah.utils").border

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { "i", "c" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false},
  }),
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
  view = {
    entries = { name = "custom", selection_order = "near_cursor" }
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = 'nvim_lsp_signature_help' },
    { name = "ultisnips" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = {
      border = border("CmpBorder"),
      -- winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      winhighlight = "Normal:NeoTreeNormal,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpBorder"),
      -- winhighlight = "Normal:CmpDocPmenu,CursorLine:PmenuSel,Search:None",
      winhighlight = "Normal:NeoTreeNormal,CursorLine:PmenuSel,Search:None",
      max_width = 60,
      max_height = 15
    },
  },
  experimental = {
    ghost_text = true,
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "buffer" } }
  )
})

cmp.setup.cmdline("?", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "buffer" } }
  )
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline" } }
  )
})
