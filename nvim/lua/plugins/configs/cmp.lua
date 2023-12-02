local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local utils = require("ah.utils")

local function format(_, item)
  local max_width = 50
  local function whitespace(max, len)
    return (''):rep(max - len - 3)
  end

  -- Limit content width.
  local content = item.abbr
  if #content > max_width then
    item.abbr = vim.fn.strcharpart(content, 0, max_width) .. '…'
  else
    item.abbr = content .. whitespace(max_width, #content)
  end

  -- Replace kind with icons.
  item.kind = string.format("%s %s", utils.icons[item.kind], item.kind)

  -- Remove gibberish.
  item.menu = nil
  return item
end

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
    -- format = function(_, item)
    --   item.kind = string.format("%s %s", utils.icons[item.kind], item.kind)
    --   return item
    -- end,
    format = format
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
      border = utils.border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      -- winhighlight = "Normal:TelescopePromptNormal,CursorLine:PmenuSel,Search:None",
      scrollbar = false,
      col_offset = 2,
    },
    documentation = {
      border = utils.border("CmpBorder"),
      winhighlight = "Normal:CmpDocPmenu,CursorLine:PmenuSel,Search:None",
      -- winhighlight = "Normal:NeoTreeNormal,CursorLine:PmenuSel,Search:None",
      max_width = 70,
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
