local present, notify = pcall(require, "notify")
if not present then
  return
end

local options = {
  timeout = 2000,
  stages = "fade",
  render = 'wrapped-compact'
}

return notify.setup(options)
