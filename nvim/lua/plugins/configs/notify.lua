local present, notify = pcall(require, "notify")
if not present then
  return
end

notify.setup({
  timeout = 2000,
  stages = "fade"
})

vim.notify = require("notify")
