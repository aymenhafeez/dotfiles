local function search_count()
  tbl = {}
  local count = vim.fn.searchcount { recompute = 1 }
  return count.current .. "/" .. count.total
end

P(search_count())

-- local ns = vim.api.nvim_create_namespace "test:virttext"

-- vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

-- local line = vim.fn.line "."
-- local offset = 3
-- local col = vim.fn.col "."

-- vim.api.nvim_buf_set_extmark(0, ns, line, 0, {
--   virt_text = { { tostring(search_count()), "Comment" } },
--   virt_text_pos = "eol_right_align",
-- })

-- vim.api.nvim_create_autocmd("SearchWrapped", {
--   group = vim.api.nvim_create_augroup("VirtualText", { clear = true }),
--   pattern = "*",
--   callback = function()
--     local count = vim.fn.searchcount { recompute = 1 }
--     local search_ns = vim.api.nvim_create_namespace "search:virttext"
--     vim.api.nvim_buf_clear_namespace(0, search_ns, 0, -1)
--     local lines = vim.fn.line "."
--     vim.api.nvim_buf_set_extmark(0, search_ns, lines, 0, {
--       virt_text = { { tostring(count.current .. "/" .. count.total) } },
--       virt_text_pos = "eol_right_align",
--     })
--   end,
-- })

local search_virttext = function()
  local count = vim.fn.searchcount { recompute = 1 }
  local search_ns = vim.api.nvim_create_namespace "search:virttext"
  vim.api.nvim_buf_clear_namespace(0, search_ns, 0, -1)
  local lines = vim.fn.line "."
  vim.api.nvim_buf_set_extmark(0, search_ns, lines, 0, {
    virt_text = { { tostring(count.current .. "/" .. count.total) } },
    virt_text_pos = "eol_right_align",
  })
end

-- vim.keymap.set("n", "n", function()
-- end)
