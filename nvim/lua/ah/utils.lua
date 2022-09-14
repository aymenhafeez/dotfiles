local M = {}

M.source_lua = function()
  if vim.bo.filetype == "lua" then
    vim.api.nvim_exec("luafile %", false)
  elseif vim.bo.filetype == "vim" then
    vim.api.nvim_exec("source %", false)
  end
end

M.lazy_load = function(tb)
  vim.api.nvim_create_autocmd(tb.events, {
    group = vim.api.nvim_create_augroup(tb.augroup_name, {}),
    callback = function()
      if tb.condition() then
        vim.api.nvim_del_augroup_by_name(tb.augroup_name)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if tb.plugin ~= "nvim-treesitter" then
          vim.defer_fn(function()
            require("packer").loader(tb.plugin)
            if tb.plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("packer").loader(tb.plugin)
        end
      end
    end,
  })
end

M.on_file_open = function(plugin_name)
  M.lazy_load {
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "BeLazyOnFileOpen" .. plugin_name,
    plugin = plugin_name,
    condition = function()
      local file = vim.fn.expand "%"
      return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
    end,
  }
end

M.packer_cmds = {
  "PackerSnapshot",
  "PackerSnapshotRollback",
  "PackerSnapshotDelete",
  "PackerInstall",
  "PackerUpdate",
  "PackerSync",
  "PackerClean",
  "PackerCompile",
  "PackerStatus",
  "PackerProfile",
  "PackerLoad",
}

M.treesitter_cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

M.mason_cmds = {
  "Mason",
  "MasonInstall",
  "MasonInstallAll",
  "MasonUninstall",
  "MasonUninstallAll",
  "MasonLog",
}

M.gitsigns = function()
  vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
    callback = function()
      vim.fn.system("git rev-parse " .. vim.fn.expand "%:p:h")
      if vim.v.shell_error == 0 then
        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
        vim.schedule(function()
          require("packer").loader "gitsigns.nvim"
        end)
      end
    end,
  })
end

M.icons = {
  Namespace = "",
  Text = "﬍ ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "[]",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = "  ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
}

M.border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

M.cmp_border = function(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

-- testing some stuff
M.open_float = function()
  local opts = {
    relative = "cursor",
    bufpos = {0, 1},
    width = 40,
    height = 10,
    border = "rounded",
  }
  local buf vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(0, 0, -1, true, {"0", "1"})
  vim.api.nvim_open_win(0, true, opts)
end

M.tableCount = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
--

return M
