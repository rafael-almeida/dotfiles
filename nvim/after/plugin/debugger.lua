-- DAP
-- ============================================================================

local dap = require("dap")

vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint)
vim.keymap.set('n', "<leader>dl", function()
    dap.set_breakpoint(nil, nil, vim.fn.input('log message: '))
end)

vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>dv", dap.step_over)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>dr", dap.restart)
vim.keymap.set("n", "<leader>dt", dap.terminate)

-- DAP Python
-- ============================================================================

local dap_python = require("dap-python")

-- dap_python.test_runner = 'pytest'
vim.keymap.set("n", "<leader>dM", dap_python.test_method)
vim.keymap.set("n", "<leader>dC", dap_python.test_class)
vim.keymap.set("v", "<leader>dS", function()
    vim.api.nvim_input("<ESC>")
    dap_python.debug_selection()
end)

-- DAP UI
-- ============================================================================

local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Telescope DAP
-- ============================================================================

-- local telescope = require("telecope")
--
-- vim.keymap.set("", "", telescope.extensions.dap.commands)
-- vim.keymap.set("", "", telescope.extensions.dap.configurations)
-- vim.keymap.set("", "", telescope.extensions.dap.list_breakpoints)
-- vim.keymap.set("", "", telescope.extensions.dap.variables)
-- vim.keymap.set("", "", telescope.extensions.dap.frames)
