local map = require("usr.map").map

-- disable arrow keys
map("n", "<Up>", "<nop>")
map("n", "<Down>", "<nop>")
map("n", "<Left>", "<nop>")
map("n", "<Right>", "<nop>")

-- disable repeat the last recorded register
map("n", "Q", "<nop>")

-- toggle explorer
map("n", "<leader>n", ":Exp<CR>")

-- make Y behave like it should
map("n", "Y", "yg$")

-- copy to clipboard
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")
map("v", "<leader>Y", "\"+Y")

-- paste from clipboard
map("n", "<leader>p", "\"+p")
map("v", "<leader>p", "\"+p")
map("n", "<leader>P", "\"+P")
map("v", "<leader>P", "\"+P")

-- use black hole register
map("n", "<leader>x", "\"_x")
map("v", "<leader>x", "\"_x")
map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")
map("n", "<leader>D", "\"_D")
map("v", "<leader>D", "\"_D")
map("n", "<leader>c", "\"_c")
map("v", "<leader>c", "\"_c")
map("n", "<leader>C", "\"_C")
map("v", "<leader>C", "\"_C")

-- maintain cursor's position after line join
map("n", "J", "mzJ`z")

-- maintain visual mode after indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move line(s) up and down
map("v", "<C-k>", ":m '<-2<CR>gv=gv")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")

-- center cursor when moving page
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- center cursor when searching
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- navigate errors
map("n", ";p", ":lprevious<CR>")
map("n", ";n", ":lnext<CR>")

-- navigate buffers
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<S-l>", ":bnext<CR>")

-- navigate windows
map("n", "<C-k>", "<C-W><C-k>")
map("n", "<C-j>", "<C-W><C-j>")
map("n", "<C-h>", "<C-W><C-h>")
map("n", "<C-l>", "<C-W><C-l>")

-- resize window
map("n", "<A-=>", "<C-w>=")
map("n", "<A-k>", "<C-W>+")
map("n", "<A-j>", "<C-W>-")
map("n", "<A-h>", "<C-W><")
map("n", "<A-l>", "<C-W>>")
map("n", "<A-,>", "<C-W>5<")
map("n", "<A-.>", "<C-W>5>")
