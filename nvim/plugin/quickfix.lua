-- send output of command to quickfix window
vim.api.nvim_create_user_command("Output", function(opts)
  local args = opts.fargs
  local output = vim.fn.execute(vim.fn.join(args, " "))
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, "r", {
    title = "Output",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end, { nargs = "*" })

-- view messages in quickfix window
vim.api.nvim_create_user_command("Mess", function()
  local output = vim.fn.execute "messages"
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, "r", {
    title = "Messages",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end, {})
