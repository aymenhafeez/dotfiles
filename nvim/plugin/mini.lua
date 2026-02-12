vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" }, { load = false })

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
      lsp_progress = { enable = true },
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

    setup("mini.indentscope", { draw = { delat = 50 }, symbol = "│" })
    setup("mini.tabline", { show_icons = false })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "markdown" },
  callback = function()
    vim.b.miniindentscope_disable = true
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
  end
})

setup("mini.files", {
  mappings = {
    go_in = "l",
    go_in_plus = "<CR>"
  },
  content = {
    prefix = function() end
  },
  windows = {
    preview = true,
    width_nofocus = 50,
    width_preview = 75,
  }
})

vim.keymap.set("n", "<leader>-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), false) end)

vim.keymap.set("n", "<leader>d-", function()
  local prompt = vim.fn.input("Enter directory> ")
  if prompt == "" then
    return ""
  end

  require("mini.files").open(prompt, false)
end)

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

-- setup("mini.icons")
