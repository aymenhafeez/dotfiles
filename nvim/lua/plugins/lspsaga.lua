local status, saga = pcall(require, 'lspsaga')
if (not status) then return end


saga.init_lsp_saga {
  -- use_saga_diagnostic_sign = false
  code_action_lightbulb = {
      enable = false,
  },
  diagnostic_header = { " ", " ", " ", "ﴞ " },
}
