local present, notify = pcall(require, "notify")
if not present then
  return
end

local options = {
  timeout = 2000,
  stages = "fade",
  render = 'wrapped-compact',
  top_down = false,
}

return notify.setup(options)
