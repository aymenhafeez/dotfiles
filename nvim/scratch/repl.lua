-- -- TODO: send commands/command output to a specific window
--
-- local on_exit = function(obj)
--   print(obj.code)
--   print(obj.signal)
--   print(obj.stdout)
--   print(obj.stderr)
-- end
--
-- -- vim.system({ "echo", "hello" }, { text = true }, on_exit)

-- local bufnr = vim.api.nvim_get_current_buf()
local bufnr = 83

vim.keymap.set("n", "<leader>rp", function()
  vim.fn.jobstart({ "ls", "-al" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
      end
    end,
  })
end)
