-- toggle quickfix / location list
local function toggle_list(kind)
  local list, open_cmd, close_cmd

  if kind == "qf" then
    list = vim.fn.getqflist({ winid = 1, items = 1 })
    open_cmd, close_cmd = "copen", "cclose"
  else
    list = vim.fn.getloclist(0, { winid = 1, items = 1 })
    open_cmd, close_cmd = "lopen", "lclose"
  end

  local winid = list.winid
  local items = list.items or {}

  -- if winid == 0 and #items == 0 then
  --   return
  if winid == 0 then
    vim.cmd(open_cmd)
  else
    vim.cmd(close_cmd)
  end
end

vim.keymap.set("n", "<leader>q", function()
  toggle_list("qf")
end)

vim.keymap.set("n", "<leader>l", function()
  pcall(toggle_list, "loc")
end)
