vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
}, { load = false })

local function setup(module, opts)
  local present, mod = pcall(require, module)
  if present then
    mod.setup(opts or {})
  end
end

vim.g.omni_sql_default_compl_type = 'syntax'

-- :h MiniSurround-vim-surround-config
require("utils").lazy_load({ "InsertEnter", "CmdlineEnter" },
  function()
    setup("mini.surround", {
      mappings = {
        add = "ys",
        delete = "ds",
        find = "",
        find_left = "",
        highlight = "",
        replace = "cs",

        suffix_last = "",
        suffix_next = "",
      },
      search_method = "cover_or_next",
    })

    vim.keymap.del("x", "ys")
    vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true, desc = "Add surrounding" })

    setup("mini.pairs")
  end)
