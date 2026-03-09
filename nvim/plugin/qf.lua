-- toggle quickfix / location list
local function toggle_list(kind)
  local list, open_cmd, close_cmd

  if kind == "qf" then
    list = vim.fn.getqflist({ winid = 1, items = 1 })
    open_cmd, close_cmd = "copen", "cclose"
  else
    list = vim.fn.getloclist(0, { winid = 1, items = 1 })
    open_cmd, close_cmd = "lopen", "lclose"
  end

  local winid = list.winid
  local items = list.items or {}

  if winid == 0 and #items == 0 then
    return
  elseif winid == 0 then
    vim.cmd(open_cmd)
  else
    vim.cmd(close_cmd)
  end
end

vim.keymap.set("n", "<leader>q", function()
  toggle_list("qf")
end, { desc = "Toggle quickfix" })

vim.keymap.set("n", "<leader>l", function()
  toggle_list("loc")
end, { desc = "Toggle location list" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.wrap = false
    vim.opt_local.statuscolumn = ""
  end,
})

-- navigate the quickfix list if it's open otherwise move the current line up and down
---@diagnostic disable: param-type-mismatch
vim.keymap.set({ "n", "t" }, "<M-C-j>", function()
  local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
  local loclist_id = vim.fn.getloclist(0, { winid = 1 }).winid
  if qflist_id > 0 then
    pcall(vim.cmd, "cnext")
  elseif loclist_id > 0 then
    pcall(vim.cmd, "lnext")
  else
    vim.cmd [[m .+1<CR>==]]
  end
end, { desc = "Next quickfix/loclist item or move line down" })

vim.keymap.set({ "n", "t" }, "<M-C-k>", function()
  local qflist_id = vim.fn.getqflist({ winid = 1 }).winid
  local loclist_id = vim.fn.getloclist(0, { winid = 1 }).winid
  if qflist_id > 0 then
    pcall(vim.cmd, "cprev")
  elseif loclist_id > 0 then
    pcall(vim.cmd, "lprev")
  else
    vim.cmd [[m .-2<CR>==]]
  end
end, { desc = "Previous quickfix/loclist item or move line up" })
