if vim.env.TMUX then
  vim.pack.add({
    "https://github.com/alexghergh/nvim-tmux-navigation"
  })

  local function nav(direction)
    local tmux_dir = { h = "L", j = "D", k = "U", l = "R" }
    local edge     = { h = "left", j = "bottom", k = "top", l = "right" }
    local wrap     = { h = "previous-window", j = "next-window", k = "previous-window", l = "next-window" }

    local winnr    = vim.fn.winnr()
    pcall(vim.cmd, "wincmd " .. direction)

    if winnr == vim.fn.winnr() then
      local socket = vim.fn.split(vim.env.TMUX, ",")[1]
      vim.fn.system(
        "tmux -S " .. socket
        .. " if-shell -F '#{pane_at_" .. edge[direction] .. "}' '"
        .. wrap[direction] .. "' 'select-pane -" .. tmux_dir[direction] .. "'"
      )
    end
  end

  vim.keymap.set({ "n", "t" }, "<M-h>", function() nav("h") end)
  vim.keymap.set({ "n", "t" }, "<M-j>", function() nav("j") end)
  vim.keymap.set({ "n", "t" }, "<M-k>", function() nav("k") end)
  vim.keymap.set({ "n", "t" }, "<M-l>", function() nav("l") end)
end
