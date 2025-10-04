local map = vim.keymap.set
local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.textwidth = 80
opt.formatoptions:append { "tcqj" }
opt.conceallevel = 2
opt_local.spell = true
opt_local.complete:append { "kspell" }
g.tex_conceal = "abdmgs"
g.tex_flavor = "latex"

map("i", "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below"})
map("i", "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })

map("n", "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below" })
map("n", "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })
map("n", "<C-c><C-l>", "i\\left<Esc>l%i\\right<Esc>", { noremap = true, silent = true })

local Terminal = require("toggleterm.terminal").Terminal

-- Create a single LaTeX terminal instance (empty for now)
local latex_term = Terminal:new({ hidden = false, close_on_exit = false, direction = "horizontal" })

vim.keymap.set("n", "<leader>cm", function()
  local dir      = vim.fn.expand("%:p:h")   -- directory of current .tex
  local file     = vim.fn.expand("%:t")     -- filename.tex
  local basename = vim.fn.expand("%:t:r")   -- filename without extension
  local builddir = dir .. "/build"
  local pdf_path = builddir .. "/" .. basename .. ".pdf"

  local cmd = table.concat({
    "cd " .. dir,
    "mkdir -p build",
    "rm -f build/*",
    "pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build " .. file,
  }, " && ")

  -- Update the terminal command before each run
  latex_term.cmd = cmd

  -- Override on_exit each time (so it checks the current file)
  latex_term.on_exit = function(_, _, _)
    if vim.fn.filereadable(pdf_path) == 1 then
      vim.notify("✔ Compilation succeeded: " .. pdf_path, "info", { title = "LaTeX" })
    else
      vim.notify("✘ Compilation failed — check logs", "error", { title = "LaTeX" })
    end
  end

  -- Run it (reuses same terminal buffer every time)
  latex_term:toggle()
end, { noremap = true, silent = true, desc = "Compile LaTeX to PDF (reuse term)" })

-- map("n", "<leader>cm", function()
--   local file = vim.fn.expand("%:t")
--   vim.cmd("TermExec cmd='pdflatex -output-directory=build " .. file .. "' open=0")
-- end, { noremap = true, silent = true, desc = "Compile to PDF" })

map("n", "<leader>pv", "<cmd>TermExec cmd='open build/%:t:r.pdf' open=0<CR>", { desc = "Open PDF preview" })
map("n", "<leader>lv", "<cmd>TeXpresso %<CR>", { desc = "Open live preview with TeXpresso" })

map("i", "zx", "\\", { noremap = true, silent = true, desc = "Insert backslash on 65% keyboard"})

-- vimtex mappings
map("n", "<leader>vt", "<cmd>VimtexTocToggle<CR>", { desc = "Toggle contents" })
