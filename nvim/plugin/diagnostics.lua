vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.diagnostic.config {
      severity_sort = true,
      signs = false,
      virtual_text = true,
      jump = {
        float = true,
        wrap = false,
      },
      float = {
        source = true
      }
    }
  end
})

-- :h diagnostic-toggle-virtual-lines-example
vim.keymap.set("n", "gL", function()
  local virtlines_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = virtlines_config })
end)

-- toggle virtual_text
vim.keymap.set("n", "gV", function()
  local virttext_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = virttext_config })
end)

-- local diagnostic_float = nil
--
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		if vim.fn.mode() ~= "n" then
-- 			return
-- 		end
--
-- 		local diagnostics = vim.diagnostic.get(0, { scope = "cursor" })
-- 		if #diagnostics == 0 then
-- 			return
-- 		end
--
-- 		vim.diagnostic.open_float(nil, {
-- 			focus = false,
-- 			scope = "cursor",
-- 			border = "rounded",
-- 		})
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("WinClosed", {
-- 	callback = function(args)
-- 		if diagnostic_float and tostring(diagnostic_float) == args.match then
-- 			diagnostic_float = nil
-- 		end
-- 	end,
-- })
