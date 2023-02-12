vim.keymap.set("n", "<leader>B", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set('n', '<Leader>dl', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('log message: '))
end)

vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<leader>dv", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require('dap').restart()<CR>")
vim.keymap.set("n", "<leader>dt", ":lua require('dap').terminate()<CR>")


-- ============================================================================

local dap, dapui = require("dap"), require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- ============================================================================

local dap_python = require("dap-python")

dap_python.setup("~/.virtualenvs/debugpy/bin/python")
-- dap_python.test_runner = 'pytest'

vim.keymap.set("n", "<leader>dM", ":lua require('dap-python').test_method()<CR>")
vim.keymap.set("n", "<leader>dC", ":lua require('dap-python').test_class()<CR>")
vim.keymap.set("v", "<leader>dS", "<ESC>:lua require('dap-python').debug_selection()<CR>")

-- ============================================================================
