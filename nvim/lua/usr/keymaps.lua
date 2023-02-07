-- vim.keymap.set("n", "<leader>@a<", ':let @a=@"<CR>')
-- vim.keymap.set("n", "<leader>@a>", ':let @"=@a<CR>')

-- wrap selection
vim.keymap.set("v", "<leader>'", "c'<C-R>\"'<ESC>")
vim.keymap.set("v", '<leader>"', 'c"<C-R>""<ESC>')
vim.keymap.set("v", "<leader>`", 'c`<C-R>"`<ESC>')
vim.keymap.set("v", "<leader>(", 'c(<C-R>")<ESC>')
vim.keymap.set("v", "<leader>[", 'c[<C-R>"]<ESC>')
vim.keymap.set("v", "<leader>{", 'c{<C-R>"}<ESC>')
vim.keymap.set("v", "<leader><", 'c<<C-R>"><ESC>')

-- disable arrow keys
vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

-- disable repeat the last recorded register
vim.keymap.set("n", "Q", "<nop>")

-- toggle explorer
vim.keymap.set("n", "<leader>n", ":Exp<CR>")

-- make Y behave like it should
vim.keymap.set("n", "Y", "yg$")

-- copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>Y", "\"+Y")

-- paste from clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")
vim.keymap.set("v", "<leader>P", "\"+P")

-- use black hole register
vim.keymap.set("n", "<leader>x", "\"_x")
vim.keymap.set("v", "<leader>x", "\"_x")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_D")
vim.keymap.set("v", "<leader>D", "\"_D")
vim.keymap.set("n", "<leader>c", "\"_c")
vim.keymap.set("v", "<leader>c", "\"_c")
vim.keymap.set("n", "<leader>C", "\"_C")
vim.keymap.set("v", "<leader>C", "\"_C")

-- maintain cursor's position after line join
vim.keymap.set("n", "J", "mzJ`z")

-- maintain visual mode after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- center cursor when moving page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center cursor when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move line(s) up and down
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi")

-- navigate windows
vim.keymap.set("n", "<C-k>", "<C-W><C-k>")
vim.keymap.set("n", "<C-j>", "<C-W><C-j>")
vim.keymap.set("n", "<C-h>", "<C-W><C-h>")
vim.keymap.set("n", "<C-l>", "<C-W><C-l>")

-- resize window
--vim.keymap.set("n", "<A-=>", "<C-w>=")
--vim.keymap.set("n", "<A-k>", "<C-W>+")
--vim.keymap.set("n", "<A-j>", "<C-W>-")
--vim.keymap.set("n", "<A-h>", "<C-W><")
--vim.keymap.set("n", "<A-l>", "<C-W>>")
--vim.keymap.set("n", "<A-,>", "<C-W>5<")
--vim.keymap.set("n", "<A-.>", "<C-W>5>")

-- navigate buffers
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
