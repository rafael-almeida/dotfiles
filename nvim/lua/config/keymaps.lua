local noremap = require("config.utils").noremap

-- Disables arrow keys
noremap("n", "<Up>", "<nop>")
noremap("n", "<Down>", "<nop>")
noremap("n", "<Left>", "<nop>")
noremap("n", "<Right>", "<nop>")

-- Disables Q key
noremap("n", "Q", "<nop>")

-- Toggles Explorer
noremap("n", "<leader>n", ":Exp<CR>")

-- Ignores line break character when Yanking
noremap("n", "Y", "yg$")

-- Pastes without replacing register
noremap("x", "p", '"_dP')

-- Copies to clipboard
noremap({ "n", "v" }, "<leader>y", '"+y')
noremap({ "n", "v" }, "<leader>Y", '"+Y')

-- Pastes from clipboard
noremap({ "n", "v" }, "<leader>p", '"+p')
noremap({ "n", "v" }, "<leader>P", '"+P')

-- Deletes to black hole register
noremap("v", "<C-_>", '"_d')

-- Replaces word under cursor
noremap("n", "<leader>S", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { silent = false })

-- Replaces selection
noremap("v", "<leader>S", '"zy:%s/<C-r>z//gI<Left><Left><Left>', { silent = false })

-- Centers cursor when moving page
noremap("n", "<C-d>", "<C-d>zz")
noremap("n", "<C-u>", "<C-u>zz")

-- Centers cursor when searching
noremap("n", "n", "nzzzv")
noremap("n", "N", "Nzzzv")

-- Maintains cursor's position after line join
noremap("n", "J", "mzJ`z")

-- Indents line on single key press
noremap("n", "<", "<<")
noremap("n", ">", ">>")

-- Maintains visual mode after indent
noremap("v", "<", "<gv")
noremap("v", ">", ">gv")

-- Moves lines up and down
noremap("n", "<C-S-k>", ":m .-2<CR>==g<Esc>")
noremap("v", "<C-S-k>", ":m \'<-2<CR>gv=gv")
noremap("i", "<C-S-k>", "<Esc>:m .-2<CR>==gi")

noremap("n", "<C-S-j>", ":m .+1<CR>==g<Esc>")
noremap("v", "<C-S-j>", ":m \'>+1<CR>gv=gv")
noremap("i", "<C-S-j>", "<Esc>:m .+1<CR>==gi")

-- Splits windows
noremap("n", "<C-W>s", ":split<CR><C-W><C-j><CR>")
noremap("n", "<C-W>v", ":vsplit<CR><C-W><C-l><CR>")

-- Navigates windows
noremap("n", "<C-W>k", "<C-W><C-k>")
noremap("n", "<C-W>j", "<C-W><C-j>")
noremap("n", "<C-W>h", "<C-W><C-h>")
noremap("n", "<C-W>l", "<C-W><C-l>")

-- Navigates buffers
noremap("n", "<S-h>", ":bprevious<CR>")
noremap("n", "<S-l>", ":bnext<CR>")
noremap("n", "<S-q>", ":bd<CR>")
