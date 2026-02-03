vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" }, { load = false })

local group = vim.api.nvim_create_augroup("LazyLoad", { clear = false })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  once = true,
  callback = function()
    require("mini.notify").setup {
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
    }
  end
})

vim.keymap.set("n", "<leader>tn", function()
  require("mini.notify").show_history()
end)

-- :h MiniSurround-vim-surround-config
vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter", "TermOpen" }, {
  group = group,
  once = true,
  callback = function()
    require("mini.surround").setup {
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
    }

    vim.keymap.del("x", "ys")
    vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

    require("mini.pairs").setup()
  end
})

require("mini.files").setup()

vim.keymap.set("n", "<leader>-",
  function() require("mini.files").open(nil, true, { windows = { preview = true, width_preview = 75 } }) end)

-- snippets from :h mini.files
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = require("mini.files").get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)

    require("mini.files").set_target_window(new_target)
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    map_split(buf_id, "<C-s>", "belowright horizontal")
    map_split(buf_id, "<C-v>", "belowright vertical")
    map_split(buf_id, "<C-t>", "tab")
  end,
})
