local util = require("config.util")

-- Disables arrow keys
util.noremap("n", "<Up>", "<nop>")
util.noremap("n", "<Down>", "<nop>")
util.noremap("n", "<Left>", "<nop>")
util.noremap("n", "<Right>", "<nop>")

-- Disables Q key
util.noremap("n", "Q", "<nop>")

-- Toggles Explorer
util.noremap("n", "<leader>n", ":Exp<CR>")

-- Ignores line break character when Yanking
util.noremap("n", "Y", "yg$")

-- Pastes without replacing register
util.noremap("x", "p", '"_dP')

-- Copies to clipboard
util.noremap({ "n", "v" }, "<leader>y", '"+y')
util.noremap({ "n", "v" }, "<leader>Y", '"+Y')

-- Pastes from clipboard
util.noremap({ "n", "v" }, "<leader>p", '"+p')
util.noremap({ "n", "v" }, "<leader>P", '"+P')

-- Deletes to black hole register
util.noremap("v", "<C-_>", '"_d')

-- Replaces word under cursor
util.noremap("n", "<leader>S", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { silent = false })

-- Replaces selection
util.noremap("v", "<leader>S", '"zy:%s/<C-r>z//gI<Left><Left><Left>', { silent = false })

-- Centers cursor when moving page
util.noremap("n", "<C-d>", "<C-d>zz")
util.noremap("n", "<C-u>", "<C-u>zz")

-- Centers cursor when searching
util.noremap("n", "n", "nzzzv")
util.noremap("n", "N", "Nzzzv")

-- Maintains cursor's position after line join
util.noremap("n", "J", "mzJ`z")

-- Indents line on single key press
util.noremap("n", "<", "<<")
util.noremap("n", ">", ">>")

-- Maintains visual mode after indent
util.noremap("v", "<", "<gv")
util.noremap("v", ">", ">gv")

-- Moves lines up and down
util.noremap("n", "<C-k>", ":m .-2<CR>==g<Esc>")
util.noremap("v", "<C-k>", ":m \'<-2<CR>gv=gv")
util.noremap("i", "<C-k>", "<Esc>:m .-2<CR>==gi")

util.noremap("n", "<C-j>", ":m .+1<CR>==g<Esc>")
util.noremap("v", "<C-j>", ":m \'>+1<CR>gv=gv")
util.noremap("i", "<C-j>", "<Esc>:m .+1<CR>==gi")

-- Splits windows
util.noremap("n", "<C-W>s", ":split<CR><C-W><C-j><CR>")
util.noremap("n", "<C-W>v", ":vsplit<CR><C-W><C-l><CR>")

-- Navigates windows
util.noremap("n", "<C-W>k", "<C-W><C-k>")
util.noremap("n", "<C-W>j", "<C-W><C-j>")
util.noremap("n", "<C-W>h", "<C-W><C-h>")
util.noremap("n", "<C-W>l", "<C-W><C-l>")

-- Navigates buffers
util.noremap("n", "<S-h>", ":bprevious<CR>")
util.noremap("n", "<S-l>", ":bnext<CR>")
util.noremap("n", "<S-q>", ":bd<CR>")
