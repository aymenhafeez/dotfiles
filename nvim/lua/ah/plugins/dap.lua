return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    -- "rcarriga/nvim-dap-ui",
    "igorlfs/nvim-dap-view",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require "dap"
    -- local ui = require "dapui"
    local dap_python = require "dap-python"

    -- ui.setup()
    dap_python.setup()
    require("nvim-dap-virtual-text").setup()

    dap_python.setup "python3"

    vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
    vim.keymap.set("n", "<leader>cc", dap.continue)
    vim.keymap.set("n", "<leader>ci", dap.step_into)
    vim.keymap.set("n", "<leader>co", dap.step_over)
    vim.keymap.set("n", "<leader>c0", dap.step_out)
    vim.keymap.set("n", "<leader>cb", dap.step_back)
    vim.keymap.set("n", "<leader>cr", dap.restart)

    -- vim.keymap.set("n", "<leader>?", function()
    --   ui.eval(nil, { enter = true })
    -- end)

    -- dap.listeners.before.attach.dapui_config = function()
    --   ui.open()
    -- end
    -- dap.listeners.before.launch.dapui_config = function()
    --   ui.open()
    -- end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    --   ui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    --   ui.close()
    -- end
  end,
}
