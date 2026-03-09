vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = "pum,fuzzy,tagfile"

vim.api.nvim_create_autocmd("CmdlineChanged", {
  callback = function()
    local t = vim.fn.getcmdtype()
    if t == ":" or t == "/" or t == "?" then
      vim.fn.wildtrigger()
    end
  end,
})

local filescache = {}
local cache_cwd = nil

local function get_files()
  local cwd = vim.uv.cwd()

  if cache_cwd == cwd and not vim.tbl_isempty(filescache) then
    return filescache
  end

  local result = vim.system({
    "rg",
    "--files",
    "--hidden",
    "--glob",
    "!.git",
    "--no-config",
  }, {
    text = true,
    cwd = cwd,
  }):wait()

  if result.code ~= 0 then
    filescache = {}
    cache_cwd = cwd
    return filescache
  end

  filescache = vim.split(result.stdout, "\n", { trimempty = true })
  cache_cwd = cwd
  return filescache
end

_G.__cmdline_fuzzy_find = function(arg)
  local files = get_files()
  return arg == "" and files or vim.fn.matchfuzzy(files, arg)
end

vim.opt.findfunc = "v:lua.__cmdline_fuzzy_find"

vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    if vim.fn.getcmdtype() == ":" then
      filescache = {}
      cache_cwd = nil
    end
  end,
})

vim.keymap.set("n", "<leader>f", ":find ")
