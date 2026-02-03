vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>Dq", vim.diagnostic.setqflist)

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

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    local qf = vim.fn.getqflist({ winid = 1 })
    if qf.winid ~= 0 then
      vim.diagnostic.setqflist({ open = true })
    end

    local loc = vim.fn.getloclist(0, { winid = 1 })
    if loc.winid ~= 0 then
      vim.diagnostic.setloclist({ open = true, bufnr = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.wrap = false
  end,
})

vim.opt.switchbuf = "useopen,uselast"

-- send output of command to quickfix window
vim.api.nvim_create_user_command("OP", function(opts)
  local args = opts.fargs
  local output = vim.fn.execute(vim.fn.join(args, " "))
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, "a", {
    title = "Output",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end, { nargs = "*" })

-- view messages in quickfix window
vim.api.nvim_create_user_command("Mess", function()
  local output = vim.fn.execute "messages"
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, "r", {
    title = "Messages",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
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
end)

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
end)

-- execute current file and send output to quickfix list
vim.keymap.set("n", "<leader><leader>x", function()
  local result = vim.api.nvim_exec2("source %", { output = true })
  local output = result.output
  local split_lines = vim.split(output, "\n")
  vim.fn.setqflist({}, " ", {
    title = "Execute",
    lines = split_lines,
  })
  vim.cmd "copen"
  vim.cmd "normal G"
end)
