local term = require "terminal"

vim.keymap.set("t", "<C-[><C-[>", "<C-\\><C-n>")

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

vim.keymap.set("t", "<M-h>", "<C-\\><C-n><C-W>2<i")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><C-W>2>i")
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><C-W>2-i")
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><C-W>2+i")

vim.keymap.set({ "n", "t" }, "<leader>tt", function()
  require("terminal").toggle_terminal {}
end)

vim.keymap.set("n", "<leader>tg", function()
  require("terminal").toggle_terminal { name = "lazygit", floating = true, cmd = "lazygit" }
end)

vim.keymap.set({ "n", "t" }, "<leader>vt", function()
  require("terminal").toggle_terminal { direction = "right" }
end)

vim.keymap.set({ "n", "t" }, "<leader><leader>t", function()
  vim.cmd "tabnew"
  vim.cmd "term"
  vim.cmd "startinsert"
end)

vim.keymap.set({ "n", "t" }, "<leader>ft", function()
  require("terminal").toggle_terminal { name = "floating", floating = true }
end)

vim.api.nvim_set_hl(0, "TerminalWinbarActive", { link = "Winbar" })
vim.api.nvim_set_hl(0, "TerminalWinbarInactive", { link = "WinbarNC" })

local function term_winbar()
  local current_buf = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  local items = {}

  local terminals = {}
  for _, buf in ipairs(buflist) do
    if vim.api.nvim_buf_is_loaded(buf) and
        vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
      table.insert(terminals, buf)
    end
  end

  table.sort(terminals)

  for _, buf in ipairs(terminals) do
    local bufname = vim.api.nvim_buf_get_name(buf)
    local job_id, command = bufname:match("term://.*//(%d+):(.*)")
    local title = command or "term-" .. buf

    if command then
      if title:match("/") then -- /usr/bin/fish -> fish)
        title = title:match("([^/]+)$")
      end

      if #title > 20 then
        title = title:sub(1, 17) .. "..."
      end
    end

    local item
    if buf == current_buf then
      item = "%#TerminalWinbarActive#" .. title .. "%*"
    else
      item = "%#TerminalWinbarInactive#" .. title .. "%*"
    end

    table.insert(items, item)
  end

  if #items == 0 then
    return ""
  end

  return table.concat(items, " ")
end

-- need to update all terminal winbars
local function update_all_terminal_winbars()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_valid(buf) and
        vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
      vim.wo[win].winbar = term_winbar()
    end
  end
end

local group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
    vim.opt_local.scrolloff = 0
    vim.wo.statuscolumn = ""
    vim.wo.winfixwidth = true
    vim.wo.winfixheight = true
    vim.bo.filetype = "terminal"
  end,
})

-- update winbar on terminal events
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "TermLeave", "BufEnter", "BufDelete" }, {
  group = group,
  callback = update_all_terminal_winbars,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd "startinsert"
    end
  end,
})

local job_id = 0
vim.keymap.set("n", "<leader>pt", function()
  vim.cmd.new()
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 20)
  job_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>ji", function()
  local cmd = vim.fn.input "Cmd > "
  vim.fn.chansend(job_id, { cmd .. "\r\n" })
end)
