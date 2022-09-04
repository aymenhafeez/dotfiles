local present, notify = pcall(require, "notify")
if not present then
  return
end

notify.setup({
  timeout = 2000,
  max_width = 70,
  stages = 'slide',
})
