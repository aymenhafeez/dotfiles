vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
}, { load = false })

local function setup(module, opts)
  local present, mod = pcall(require, module)
  if present then
    mod.setup(opts or {})
  end
end

require("pack_lazy").on("BufReadPost",
  function()
    setup("mini.completion", {
      delay = { completion = 25, info = 25, signature = 50 },
      window = {
        info = { height = 20 },
        signature = { height = 20 },
      },
    })

    setup("mini.git")
    setup("mini.diff", {
      view = { style = "sign", signs = { add = "┃", change = "┃", delete = "▁" } }
    })

    vim.keymap.set("n", "gH", function()
      require("mini.diff").toggle_overlay()
    end)
  end)

vim.g.omni_sql_default_compl_type = 'syntax'

-- :h MiniSurround-vim-surround-config
require("pack_lazy").on({ "InsertEnter", "CmdlineEnter" },
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

setup("mini.files", {
  content = { prefix = function() end },
  mappings = {
    go_in_plus = "<CR>"
  }
})

vim.keymap.set("n", "<leader>-", function()
  require("mini.files").open(nil, true)
end, { desc = "Files" })

vim.keymap.set("n", "<leader>d-", function()
  local prompt = vim.fn.input("Directory> ")
  require("mini.files").open("~/" .. prompt)
end, { desc = "Files choose directory" })

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

setup("mini.pick", {
  mappings = {
    move_down   = "<C-p>",
    move_up     = "<C-n>",
    delete_word = "<C-Backspace>",
  },
  options = {
    content_from_bottom = true,
  },
  source = { show = require("mini.pick").default_show }
})

-- Helper functions for custom pickers
local function pick_files_in_cwd(cwd, prompt_title)
  return function()
    require("mini.pick").builtin.files({
      tool = "rg",
    }, {
      source = {
        cwd = vim.fn.expand(cwd),
        name = prompt_title or cwd,
      },
    })
  end
end

local function pick_grep_in_cwd(cwd, prompt_title)
  return function()
    require("mini.pick").builtin.grep_live({ tool = "rg" }, {
      window = {
        config = { width = math.floor(0.75 * vim.o.columns) }
      },
      source = {
        cwd = vim.fn.expand(cwd),
        name = prompt_title or cwd,
      },
    })
  end
end

vim.keymap.set("n", "<leader>sf", require("mini.pick").builtin.files, { desc = "Files" })
vim.keymap.set("n", "<leader>sr", require("mini.extra").pickers.oldfiles, { desc = "Oldfiles" })
vim.keymap.set("n", "<leader>sh", require("mini.pick").builtin.help, { desc = "Help" })
vim.keymap.set("n", "<leader>:", require("mini.extra").pickers.history, { desc = "Command history" })

vim.keymap.set("n", "<leader>/", function()
  require("mini.extra").pickers.buf_lines { scope = "current" }
end, { desc = "Buffer search" })

vim.keymap.set("n", "<leader>sg", require("mini.pick").builtin.grep_live, { desc = "Grep" })

vim.keymap.set(
  "n",
  "<leader>s.",
  pick_files_in_cwd(vim.fn.stdpath "config", "Config")
  , { desc = "Config" })
vim.keymap.set(
  "n",
  "<leader>sl",
  pick_files_in_cwd(vim.fs.joinpath(vim.fn.stdpath("data"), "/site/pack"))
  , { desc = "Plugins" })

vim.keymap.set("n", "<leader>sn", pick_files_in_cwd("~/Documents/DataSci/", "Notes"), { desc = "Notes" })
vim.keymap.set("n", "<leader>sp", pick_files_in_cwd("~/projects/", "Projects"), { desc = "Projects" })

vim.keymap.set("n", "<leader>g.", pick_grep_in_cwd(vim.fn.stdpath "config", "Config"), { desc = "Grep config" })
vim.keymap.set("n", "<leader>gn", pick_grep_in_cwd("~/Documents/DataSci/", "Notes"), { desc = "Grep notes" })
vim.keymap.set("n", "<leader>gp", pick_grep_in_cwd("~/projects/", "Projects"), { desc = "Grep projects" })
