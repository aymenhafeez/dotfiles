local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local kind_icons = {
  Text = "﬍ ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "[]",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-l>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { "i", "c" }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
      end,
      { "i", "s", "c" }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.jump_backwards(fallback)
      end,
      { "i", "s", "c" }
    ),
  }),
  formatting = {
    fields = { "kind", "abbr",  "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = " LSP ",
        nvim_lua = " Lua λ",
        ultisnips = " UltiSnips ⋗",
        buffer = " Buffer ",
        latex_symbols = " Symbol ",
        path = " Path ",
      })[entry.source.name]
      return vim_item
    end,
  },
  view = {
    entries = { name = "custom", selection_order = "near_cursor" }
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "latex_symbols" },
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
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  experimental = {
    ghost_text = true,
  },
}

cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources(
    { { name = "cmp_git" } },
    { { name = "buffer" } }
  )
})

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
return cmp_capabilities
