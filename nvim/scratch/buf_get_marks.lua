local start_pos = vim.api.nvim_buf_get_mark(0, "<")
local end_pos = vim.api.nvim_buf_get_mark(0, ">")
local text = vim.api.nvim_buf_get_text(0, start_pos[1] - 1, start_pos[2], end_pos[1] - 1, end_pos[2] + 1, {})

vim.print(table.concat(text, "\n"))
