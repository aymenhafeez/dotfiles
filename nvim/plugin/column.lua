_G.statuscolumn = function()
  return table.concat {
    vim.v.lnum,
    " ",
    vim.F.npcall(function()
      return require("gitsigns").statuscolumn()
    end) or "",
  }
end

vim.schedule(function()
  vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
  require("gitsigns").setup {
    current_line_blame = true,
    -- current_line_blame_formatter = '   <author>, <author_time:%R> - <summary>',
  }
  vim.opt.statuscolumn = "%s%=%{%v:lua.statuscolumn()%}"
end)

vim.keymap.set("n", "gH", "<cmd>Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "gI", "<cmd>Gitsigns preview_hunk_inline<CR>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>")


local ns = vim.api.nvim_create_namespace("colorcolumn")
local column = 100

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, win, bufnr, toprow, botrow)
    if vim.api.nvim_get_current_win() ~= win then
      return false
    end

    if vim.bo[bufnr].buftype ~= "" then
      return false
    end

    if not vim.bo[bufnr].modifiable then
      return false
    end

    local target0 = column - 1
    if vim.opt.filetype:get() == "tex" then
      target0 = 86
    end

    for lnum = toprow, botrow do
      -- get the line and compute its display width (tabs, wide chars, etc.)
      local line = vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, false)[1] or ""
      local w = vim.fn.strdisplaywidth(line)

      -- only draw if the text ends before the target column
      if w < target0 then
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
          ephemeral = true,
          virt_text = { { "│", "WinSeparator" } },
          virt_text_pos = "overlay",
          virt_text_win_col = target0,
          hl_mode = "combine",
          priority = 1
        })
      end
    end

    return false
  end,
})
