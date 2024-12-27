local util = require("config.util")

-- Disable arrow keys
util.noremap("n", "<Up>", "<nop>")
util.noremap("n", "<Down>", "<nop>")
util.noremap("n", "<Left>", "<nop>")
util.noremap("n", "<Right>", "<nop>")

-- Disable Q key
util.noremap("n", "Q", "<nop>")

-- Toggle Explorer
util.noremap("n", "<leader>n", ":Exp<CR>")

-- Ignore line break character when Yanking
util.noremap("n", "Y", "yg$")

-- Paste without replacing register
util.noremap("x", "p", '"_dP')

-- Copy to clipboard
util.noremap({ "n", "v" }, "<leader>y", '"+y')
util.noremap({ "n", "v" }, "<leader>Y", '"+Y')

-- Paste from clipboard
util.noremap({ "n", "v" }, "<leader>p", '"+p')
util.noremap({ "n", "v" }, "<leader>P", '"+P')

-- Delete to black hole register
util.noremap("v", "<C-_>", '"_d')

-- Replace word under cursor
util.noremap("n", "<leader>S", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { silent = false })

-- Replace selection
util.noremap("v", "<leader>S", '"zy:%s/<C-r>z//gI<Left><Left><Left>', { silent = false })

-- Center cursor when moving page
util.noremap("n", "<C-d>", "<C-d>zz")
util.noremap("n", "<C-u>", "<C-u>zz")

-- Center cursor when searching
util.noremap("n", "n", "nzzzv")
util.noremap("n", "N", "Nzzzv")

-- Maintain cursor's position after line join
util.noremap("n", "J", "mzJ`z")

-- Indent line on single key press
util.noremap("n", "<", "<<")
util.noremap("n", ">", ">>")

-- Maintain visual mode after indent
util.noremap("v", "<", "<gv")
util.noremap("v", ">", ">gv")

-- Move lines up and down
util.noremap("n", "<C-k>", ":m .-2<CR>==g<Esc>")
util.noremap("v", "<C-k>", ":m \'<-2<CR>gv=gv")
util.noremap("i", "<C-k>", "<Esc>:m .-2<CR>==gi")

util.noremap("n", "<C-j>", ":m .+1<CR>==g<Esc>")
util.noremap("v", "<C-j>", ":m \'>+1<CR>gv=gv")
util.noremap("i", "<C-j>", "<Esc>:m .+1<CR>==gi")

-- Split windows
util.noremap("n", "<C-W>s", ":split<CR><C-W><C-j><CR>")
util.noremap("n", "<C-W>v", ":vsplit<CR><C-W><C-l><CR>")

-- Navigate windows
util.noremap("n", "<C-W>k", "<C-W><C-k>")
util.noremap("n", "<C-W>j", "<C-W><C-j>")
util.noremap("n", "<C-W>h", "<C-W><C-h>")
util.noremap("n", "<C-W>l", "<C-W><C-l>")

-- Navigate buffers
util.noremap("n", "<S-h>", ":bprevious<CR>")
util.noremap("n", "<S-l>", ":bnext<CR>")
util.noremap("n", "<S-q>", ":bd<CR>")

-- Set filetype
util.noremap("n", "<leader>tp", function()
    local ft = vim.fn.input("Filetype: ")

    if ft == "" then
        vim.cmd("echohl WarningMsg | echomsg 'No filetype provided!' | echohl None")
        return;
    end

    vim.bo.filetype = ft
end)
