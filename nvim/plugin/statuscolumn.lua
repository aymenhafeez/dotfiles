vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    require("mini.diff").setup {
      view = {
        style = "sign",
        signs = { add = "┃", change = "┃", delete = "_" },
      }
    }
  end
})

_G.minidiff_statuscolumn = function()
  local lnum = vim.v.lnum
  local bufnr = vim.api.nvim_get_current_buf()

  local ns_id = vim.api.nvim_get_namespaces()["MiniDiffViz"]
  if not ns_id then
    return "  "
  end

  local extmarks = vim.api.nvim_buf_get_extmarks(
    bufnr,
    ns_id,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true }
  )

  for _, extmark in ipairs(extmarks) do
    local details = extmark[4]
    if details and details.sign_text and details.sign_hl_group then
      return string.format("%%#%s#%s%%*", details.sign_hl_group, details.sign_text)
    end
  end

  return "  "
end

vim.opt.statuscolumn = "  %=%{v:relnum?v:relnum:v:lnum} %{%v:lua.minidiff_statuscolumn()%}"
