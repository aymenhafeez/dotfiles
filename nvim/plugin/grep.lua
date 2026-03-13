local function grep_to_qf(opts)
  opts = opts or {}

  vim.ui.input({
    prompt = "Grep> ",
    default = opts.default or "",
  }, function(input)
    if not input or input == "" then
      return
    end

    local result = vim.system({
      "rg",
      "--vimgrep",
      "--smart-case",
      "--hidden",
      "--glob", "!.git",
      "--color=never",
      input,
    }, {
      text = true,
    }):wait()

    -- rg exit codes:
    -- 0 = matches found
    -- 1 = no matches
    -- >1 = actual error
    if result.code > 1 then
      vim.notify(
        ("rg failed: %s"):format((result.stderr or ""):gsub("%s+$", "")),
        vim.log.levels.ERROR
      )
      return
    end

    local lines = vim.split(result.stdout or "", "\n", { trimempty = true })

    if vim.tbl_isempty(lines) then
      vim.fn.setqflist({}, "r", {
        title = ("rg: %s"):format(input),
        lines = {},
      })
      vim.notify(("No matches for %q"):format(input), vim.log.levels.INFO)
      return
    end

    vim.fn.setqflist({}, "r", {
      title = ("rg: %s"):format(input),
      lines = lines,
    })

    vim.cmd("copen")
    vim.cmd("cc")
  end)
end

vim.keymap.set("n", "<leader>gg", function()
  grep_to_qf()
end, { desc = "Ripgrep to quickfix" })

vim.api.nvim_create_user_command("RG", function(opts)
  grep_to_qf({ default = opts.args })
end, {
  nargs = "*",
  desc = "Ripgrep to quickfix",
})
