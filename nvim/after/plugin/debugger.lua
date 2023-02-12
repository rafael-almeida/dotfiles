vim.keymap.set("n", "<leader>bb", ":lua require('dap').toggle_breakpoint()<CR>")

vim.keymap.set("n", "<leader>bc", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>bt", ":lua require('dap').terminate()<CR>")

vim.keymap.set("n", "<leader>bo", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<leader>bi", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<leader>bO", ":lua require('dap').step_out()<CR>")

vim.keymap.set("n", "<leader>bR", ":lua require('dap').repl.toggle()<CR>")

local dap_ui = require("dapui")
dap_ui.setup()

vim.keymap.set("n", "<leader>bu", ":lua require('dapui').toggle()<CR>")

local dap_python = require("dap-python")
dap_python.setup("~/.virtualenvs/debugpy/bin/python")
-- dap_python.test_runner = 'pytest'

vim.keymap.set("n", "<leader>bm", ":lua require('dap-python').test_method()<CR>")
vim.keymap.set("n", "<leader>bC", ":lua require('dap-python').test_class()<CR>")
vim.keymap.set("v", "<leader>bS", "<ESC>:lua require('dap-python').debug_selection()<CR>")
