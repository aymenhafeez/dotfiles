local ns = vim.api.nvim_create_namespace "scrollbar"
local state = {}

local function get_diagnostic_hl_group(severity)
  if severity == vim.diagnostic.severity.ERROR then
    return "DiagnosticError"
  elseif severity == vim.diagnostic.severity.WARN then
    return "DiagnosticWarn"
  elseif severity == vim.diagnostic.severity.INFO then
    return "DiagnosticInfo"
  elseif severity == vim.diagnostic.severity.HINT then
    return "DiagnosticHint"
  end
  return "DiagnosticError"
end

local function on_win(_, winid, bufnr, topline, botline)
  if vim.api.nvim_win_get_config(winid).relative ~= "" then
    return false
  end

  local lines = vim.api.nvim_buf_line_count(bufnr)
  local height = vim.api.nvim_win_get_height(winid)
  if lines <= height then
    state[winid] = nil
  else
    local cells_per_line = height / lines
    local span = math.floor(0.5 + (botline - topline) * cells_per_line)
    local start = math.floor(topline + topline * cells_per_line)
    local end_ = math.min(lines, start + span + 1)

    -- map diagnostics to buffer lines where they should be displayed
    local diagnostics = vim.diagnostic.get(bufnr)
    local buffer_line_to_diag = {}

    for _, diag in ipairs(diagnostics) do
      local diag_line = diag.lnum -- 0-indexed buffer line

      -- calculate which window row this diagnostic should appear at (0 to height-1)
      local window_row = math.floor(diag_line * cells_per_line)

      -- calculate which buffer line should display this diagnostic
      local display_buffer_line = topline + window_row

      if display_buffer_line >= 0 and display_buffer_line < lines then
        if not buffer_line_to_diag[display_buffer_line]
            or diag.severity < buffer_line_to_diag[display_buffer_line].severity
        then
          buffer_line_to_diag[display_buffer_line] = {
            severity = diag.severity,
            hl_group = get_diagnostic_hl_group(diag.severity),
          }
        end
      end
    end

    -- calculate cursor position marker
    local cursor_line = vim.api.nvim_win_get_cursor(winid)[1] - 1
    local cursor_window_row = math.floor(cursor_line * cells_per_line)
    local cursor_display_line = topline + cursor_window_row
    state[winid] = {
      start = start,
      ["end"] = end_,
      buffer_line_to_diag = buffer_line_to_diag,
      cursor_display_line = cursor_display_line,
    }
  end

  vim.api.nvim__redraw { win = winid, valid = false }
  return state[winid] ~= nil
end

local function on_line(_, winid, bufnr, row)
  local win_state = state[winid]
  if not win_state then
    return
  end

  if win_state.buffer_line_to_diag[row] then
    local diag = win_state.buffer_line_to_diag[row]
    vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
      ephemeral = true,
      virt_text = { { "┃", diag.hl_group } },
      virt_text_pos = "right_align",
      virt_text_repeat_linebreak = true,
    })
  elseif row == win_state.cursor_display_line then
    vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
      ephemeral = true,
      virt_text = { { "┃", "Comment" } },
      virt_text_pos = "right_align",
      virt_text_repeat_linebreak = true,
      priority = 100,
    })
    -- elseif win_state.start <= row and row < win_state["end"] then
    --   vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
    --     ephemeral = true,
    --     virt_text = { { "▒", "NonText" } },
    --     virt_text_pos = "right_align",
    --     virt_text_repeat_linebreak = true,
    --     priority = 200,
    --   })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LazyLoad", { clear = false }),
  once = true,
  callback = function()
    vim.api.nvim_set_decoration_provider(ns, { on_win = on_win, on_line = on_line })
  end
})
