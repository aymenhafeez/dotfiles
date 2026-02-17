local current_progress = {
  client_name = nil,
  title = nil,
  message = nil,
  percentage = nil,
  status = nil,
}

local debounce_timer = nil
local debounce_delay = 50 -- makes load bar a bit smoother

local function emit_progress()
  if not current_progress.client_name then
    return
  end

  local msg = string.format("%s: %s",
    current_progress.client_name,
    current_progress.message or current_progress.title or "working..."
  )

  vim.api.nvim_echo({ { msg } }, false, {
    id = 'lsp-progress',
    kind = 'progress',
    title = current_progress.title or 'LSP',
    status = current_progress.status or 'running',
    percent = current_progress.percentage,
  })
end

local function emit_progress_debounced()
  -- not sure if this has an affect
  if debounce_timer then
    debounce_timer:stop()
  end

  debounce_timer = vim.defer_fn(function()
    emit_progress()
    debounce_timer = nil
  end, debounce_delay)
end

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('ghostty_lsp_progress', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    local val = ev.data.params.value

    if val.kind == 'begin' then
      current_progress.client_name = client.name
      current_progress.title = val.title
      current_progress.message = val.message
      current_progress.percentage = val.percentage
      current_progress.status = 'running'

      emit_progress_debounced()
    elseif val.kind == 'report' then
      current_progress.message = val.message or current_progress.message
      current_progress.percentage = val.percentage or current_progress.percentage

      emit_progress_debounced()
    elseif val.kind == 'end' then
      -- show the end completion message without a delay
      if debounce_timer then
        debounce_timer:stop()
        debounce_timer = nil
      end

      current_progress.message = val.message or 'done'
      current_progress.status = 'success'
      current_progress.percentage = 100
      emit_progress()

      vim.defer_fn(function()
        current_progress = {
          client_name = nil,
          title = nil,
          message = nil,
          percentage = nil,
          status = nil,
        }
      end, 1000)
    end
  end,
})
