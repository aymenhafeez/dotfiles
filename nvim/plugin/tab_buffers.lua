local tab_buffers = {} -- global table: tabnr -> {bufnr -> true}

-- Autocmds to track buffers per tab
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    local buf = vim.api.nvim_get_current_buf()
    tab_buffers[tab] = tab_buffers[tab] or {}
    tab_buffers[tab][buf] = true
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    local buf = vim.api.nvim_get_current_buf()
    if tab_buffers[tab] then
      tab_buffers[tab][buf] = nil
    end
  end,
})

local function get_tab_buffers()
  local tab = vim.api.nvim_get_current_tabpage()
  local bufs = {}
  for buf, _ in pairs(tab_buffers[tab] or {}) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
      table.insert(bufs, buf)
    end
  end
  return bufs
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function tab_buffers(opts)
  opts = vim.tbl_extend("force", conf, opts or {})
  local bufs = get_tab_buffers()
  if #bufs == 0 then
    vim.notify("Only one tab open atm", vim.log.levels.INFO)
    return
  end
  pickers
    .new(opts, {
      prompt_title = "Tab Buffers",
      finder = finders.new_table {
        results = bufs,
        entry_maker = function(buf)
          local name = vim.api.nvim_buf_get_name(buf)
          local loaded = vim.api.nvim_buf_is_loaded(buf)
          local changed = vim.api.nvim_buf_get_option(buf, "modified")
          local readonly = vim.api.nvim_buf_get_option(buf, "readonly")
          return {
            value = buf,
            display = string.format("%s%s%s", readonly and "RO " or "", changed and "+" or "", name),
            ordinal = name,
            bufnr = buf,
            filename = name,
            loaded = loaded,
            changed = changed,
            readonly = readonly,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.api.nvim_set_current_buf(selection.bufnr)
        end)
        return true
      end,
    })
    :find()
end

vim.keymap.set("n", "<leader>ab", tab_buffers)
