local present, scroll = pcall(require, "neoscroll")
if not present then
  return
end

scroll.setup({
  easing_function = nil,
  pre_hook = nil,
  post_hook = nil,
  performance_mode = false,
})

local t    = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", nil } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", nil } }
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "250", nil } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "250", nil } }
t["<C-y>"] = { "scroll", { "-0.20", "false", "50", nil } }
t["<C-e>"] = { "scroll", { "0.20", "false", "50", nil } }
t["zt"]    = { "zt", { "100" } }
t["zz"]    = { "zz", { "100" } }
t["zb"]    = { "zb", { "100" } }

require("neoscroll.config").set_mappings(t)
