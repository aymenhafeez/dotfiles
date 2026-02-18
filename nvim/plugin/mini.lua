vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
}, { load = false })

local function setup(module, opts)
  local present, mod = pcall(require, module)
  if present then
    require(module).setup(opts or {})
  end
end

local group = vim.api.nvim_create_augroup("LazyLoad", { clear = false })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  once = true,
  callback = function()
    setup("mini.notify", {
      lsp_progress = { enable = false },
      content = {
        sort = function(notif_arr)
          local filtered = vim.tbl_filter(function(notif)
            return not (notif.msg
              and type(notif.msg) == "string"
              and notif.msg:match("does not support command.*editor%.action%."))
          end, notif_arr)

          return require("mini.notify").default_sort(filtered)
        end,
      },
      window = {
        config = function()
          local has_statusline = vim.o.laststatus > 0
          local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
          return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
        end,
      },
    })
  end,
})

vim.keymap.set("n", "<leader>tn", function()
  require("mini.notify").show_history()
end)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("mini-notify-mappings", { clear = false }),
  pattern = "mininotify-history",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { buffer = true })
  end
})

-- :h MiniSurround-vim-surround-config
vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter", "TermOpen" }, {
  group = group,
  once = true,
  callback = function()
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
    vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

    setup("mini.pairs")
  end,
})
