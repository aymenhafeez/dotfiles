_G.statuscolumn = function()
  return table.concat {
    vim.v.relnum ~= 0 and vim.v.relnum or vim.v.lnum,
    " ",
    vim.F.npcall(function()
      return require("gitsigns").statuscolumn()
    end) or " ",
  }
end

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/lewis6991/gitsigns.nvim",
    }, { load = false })

    vim.opt.statuscolumn = "%s%=%{%v:lua.statuscolumn()%}"
    require("gitsigns").setup { current_line_blame = true }
    vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>")
    vim.keymap.set("n", "<leader>gl", "<cmd>Gitsigns preview_hunk_inline<CR>")
    vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>")
    vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>")
  end
})
