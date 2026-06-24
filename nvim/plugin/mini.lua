vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
}, { load = false })

local function setup(module, opts)
  local present, mod = pcall(require, module)
  if present then
    mod.setup(opts or {})
  end
end


require("utils").lazy_load("BufReadPre", function()
  -- setup("mini.completion", {
  --   delay = { completion = 25, info = 25, signature = 50 },
  --   window = {
  --     info = { height = 20, border = vim.o.winborder == "rounded" and "rounded" or "none" },
  --     signature = { height = 20, border = vim.o.winborder == "rounded" and "rounded" or "none" },
  --   },
  --   mappings = {
  --     scroll_down = "<C-d>",
  --     scroll_up = "<C-u>"
  --   }
  -- })

  setup("mini.indentscope", { draw = { delay = 50 }, symbol = '│', })
end)

vim.schedule(function()
  setup("mini.clue", {
    triggers = {
      -- Leader triggers
      { mode = { 'n', 'x' }, keys = '<Leader>' },

      -- `[` and `]` keys
      { mode = 'n',          keys = '[' },
      { mode = 'n',          keys = ']' },

      -- Built-in completion
      { mode = 'i',          keys = '<C-x>' },

      -- `g` key
      { mode = { 'n', 'x' }, keys = 'g' },

      { mode = { 'n' },      keys = 'y' },

      -- Marks
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },

      -- Registers
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'i', 'c' }, keys = '<C-r>' },

      -- Window commands
      { mode = { 'n', 't' }, keys = '<C-w>' },

      -- `z` key
      { mode = { 'n', 'x' }, keys = 'z' },

      { mode = { 'n' },      keys = ';' },
    },
    window = {
      delay = 300,
      config = {
        -- anchor = "NE",
        -- row = 0,
        border = vim.o.winborder == "rounded" and "rounded" or "none",
      }
    },
    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      { mode = 'n', keys = '<Leader>s', desc = '+Search' },
      { mode = 'n', keys = '<Leader>g', desc = '+Grep' },
      require("mini.clue").gen_clues.square_brackets(),
      require("mini.clue").gen_clues.builtin_completion(),
      require("mini.clue").gen_clues.g(),
      require("mini.clue").gen_clues.marks(),
      require("mini.clue").gen_clues.registers(),
      require("mini.clue").gen_clues.windows(),
      require("mini.clue").gen_clues.z(),
    },

  })

  require("mini.icons").setup()
  -- require("mini.icons").tweak_lsp_kind()
end)

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

setup("mini.files", {
  content = { prefix = function() end },
  mappings = {
    go_in_plus = "<CR>"
  },
  options = {
    use_as_default_explorer = false,
  }
})

vim.keymap.set("n", ";m", function()
  require("mini.files").open(nil, true)
end, { desc = "Files" })

vim.keymap.set("n", ";dm", function()
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
