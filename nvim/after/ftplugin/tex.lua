local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

opt.conceallevel = 2
opt_local.tabstop = 4
opt_local.shiftwidth = 4
opt_local.expandtab = true
opt_local.textwidth = 85
opt_local.formatoptions:append { "tcqj" }
opt_local.spell = true
opt_local.complete:append { "kspell", "f" }
g.tex_conceal = "abdmgs"
-- g.tex_conceal = "b"
g.tex_flavor = "latex"

map("i", "<Space>", "<Space><C-g>u", { buf = 0, desc = "Break undo sequence on space" })
map("i", "<Tab>", "<Tab><C-g>u", { buf = 0, desc = "Break undo sequence on tab" })

map({ "n", "i" }, "<C-c><C-j>", "<Esc>o\\item ", { buf = 0, desc = "New item below" })
map({ "n", "i" }, "<C-c><C-k>", "<Esc>O\\item ", { buf = 0, desc = "New item above" })

local function get_split_direction()
  local width = vim.api.nvim_win_get_width(0)
  return width > 180 and 'right' or 'below'
end

local function in_zellij()
  local env = vim.fn.getenv("ZELLIJ")
  return env ~= vim.NIL and env ~= ""
end

local file_name = vim.fn.expand "%:t:r"
local compile_args = {
  "latexmk",
  "-pdf",
  "-interaction=nonstopmode",
  "-halt-on-error",
  "-output-directory=build",
  file_name,
}
local compile_cmd = table.concat(compile_args, " ")

map("n", "<leader>cm", function()
  if in_zellij() then
    local dir = get_split_direction() == 'right' and 'right' or 'down'
    vim.fn.system {
      "zellij", "run",
      "--direction", dir,
      "--name", "latex compile",
      "--", unpack(compile_args),
    }
  else
    require("terminal").toggle_terminal({
      name = "latex compile",
      direction = get_split_direction(),
      cmd = compile_cmd,
    })
  end
end, { buf = 0, desc = "Compile LaTeX" })

map("n", "<leader>pv", function()
  vim.cmd(":!xdg-open build/" .. vim.fn.expand "%:t:r" .. ".pdf")
end, { buf = 0, desc = "Preview PDF" })

map("n", "<C-s>", "mm[s1z=`m", { buf = 0, desc = "Fix previous spelling error" })
map("i", "<C-s>", "<C-g>u<Esc>[s1z=`]a<C-g>u", { buf = 0, desc = "Fix previous spelling error" })

-- vim.api.nvim_create_autocmd("InsertEnter", {
--   once = true,
--   callback = function()
--     require("mini.snippets").setup {
--       snippets = {
--         require('mini.snippets').gen_loader.from_lang(),
--       },
--       mappings = {
--         expand = '<C-j>',
--         jump_next = '<C-j>',
--         jump_prev = '<C-k>',
--         stop = '<C-c>',
--       },
--     }
--   end
-- })
