local function toggle_zoom(count)
  if count and count > 0 then
    vim.cmd.normal({ args = { string.format("%d|", count) }, bang = true })
    return
  end

  if vim.fn.winnr("$") == 1 then
    return
  end

  local tp = vim.api.nvim_get_current_tabpage()
  local ok, state = pcall(vim.api.nvim_tabpage_get_var, tp, "restore_zoom")
  local restore_cmd = ok and state or nil

  if restore_cmd then
    vim.cmd(restore_cmd)
    pcall(vim.api.nvim_tabpage_del_var, tp, "restore_zoom")
    return
  end

  local original = vim.fn.winrestcmd()

  vim.cmd("wincmd |")
  vim.cmd("wincmd _")

  if vim.fn.winrestcmd() ~= original then
    vim.api.nvim_tabpage_set_var(tp, "restore_zoom", original)
  end
end

vim.keymap.set({ "n", "t" }, "+", function() toggle_zoom(vim.v.count) end)
