local map = vim.keymap.set

-- Buffer navigation
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer", silent = true })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer", silent = true })

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer", silent = true })

-- Git
map("n", "<leader>gg", "<cmd>Git<CR>", { desc = "Open Fugitive" })

-- Native commenting (Neovim 0.10+)
map("n", "<leader>/", "gcc", { desc = "Toggle line comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Clear search highlight
map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Better indenting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
