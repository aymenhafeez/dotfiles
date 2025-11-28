local ui = vim.api.nvim_list_uis()[1]

local width = math.floor(ui.width * 0.8)
local height = math.floor(ui.height * 0.8)

local bufnr = vim.api.nvim_create_buf(false, true)
local win = vim.api.nvim_open_win(bufnr, true, {
  relative = "editor",
  width = width,
  height = height,
  col = math.floor((vim.o.columns - width) / 2),
  row = math.floor((vim.o.lines - height) / 2),
  border = "rounded",
})

vim.api.nvim_set_option_value("winblend", 1, { win = win })
local ns_id = vim.api.nvim_create_namespace "blend"

local start_blend = 10
local offset = 1

local timer = vim.uv.new_timer()
timer:start(
  0,
  50,
  vim.schedule_wrap(function()
    start_blend = start_blend + offset

    if start_blend > 90 then
      offset = -1
    elseif start_blend < 10 then
      offset = 1
    end

    if not vim.api.nvim_win_is_valid(win) then
      timer:close()
      timer:stop()
      return
    end

    -- vim.cmd([[highlight NormalFloat blend=]] .. tostring(start_blend))
    vim.api.nvim_set_hl(ns_id, "NormalFloat", { blend = start_blend })
    vim.api.nvim_win_set_hl_ns(win, ns_id)
  end)
)
