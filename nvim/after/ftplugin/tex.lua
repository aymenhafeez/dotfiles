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

map({ "n", "i" }, "<C-c><C-j>", "<Esc>o\\item ", { noremap = true, silent = true, desc = "New item below" })
map({ "n", "i" }, "<C-c><C-k>", "<Esc>O\\item ", { noremap = true, silent = true, desc = "New item above" })
map("n", "<C-c><C-l>", "i\\left<Esc>l%i\\right<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cm", function()
  local file_path = vim.fn.expand("%:p")
  local dir      = vim.fn.expand("%:p:h")
  local basename = vim.fn.expand("%:t:r")
  local builddir = dir .. "/build"
  local pdf_path = builddir .. "/" .. basename .. ".pdf"
  local cmd = {
    "latexmk",
    "-pdf",
    "-interaction=nonstopmode",
    "-halt-on-error",
    "-output-directory=build",
    file_path,
  }
  print("latexmk compiling " .. basename .. ".tex")
  vim.system(cmd, { text = true }, function(obj)
    if obj.code == 0 and vim.fn.filereadable(pdf_path) == 1 then
      vim.schedule(function()
        vim.notify("✔ Compilation succeeded: " .. pdf_path, vim.log.levels.INFO, { title = "LaTeX" })
      end)
    else
      vim.schedule(function()
        vim.notify("✘ Compilation failed — check logs\n" .. (obj.stderr or ""), vim.log.levels.ERROR, { title = "LaTeX" })
      end)
    end
  end)
end)

-- map("n", "<leader>cm", ":TermTog latexmk -pdf -interaction=nonstopmode -halt-on-error -output-directory=build " .. file_name .. "<CR>")
map("n", "<leader>pv", function()
  vim.cmd(":!open build/" .. vim.fn.expand("%:t:r") .. ".pdf")
end, { desc = "Open PDF preview" })

map("n", "<leader>lv", "<cmd>TeXpresso %<CR>", { desc = "Open live preview with TeXpresso" })
map("i", "zx", "\\", { noremap = true, silent = true, desc = "Insert backslash on 65% keyboard"})

-- vimtex mappings
map("n", "<leader>vt", "<cmd>VimtexTocToggle<CR>", { desc = "Toggle contents" })
