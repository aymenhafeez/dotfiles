local function buf_delete()
  local alternate_buf = vim.fn.bufnr "#"

  if vim.bo.modified then
    return vim.notify("Buffer modified", vim.log.levels.WARN)
  else
    if alternate_buf == -1 then
      local empty_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(empty_buf)
      vim.cmd("bd #")
    else
      vim.api.nvim_set_current_buf(alternate_buf)
      vim.cmd("bd #")
    end
  end
end

vim.api.nvim_create_user_command("Bdelete", buf_delete, {})
vim.keymap.set("c", "bd", "Bdelete")
