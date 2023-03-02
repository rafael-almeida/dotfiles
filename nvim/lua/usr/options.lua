vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "~/.virtualenvs/neovim/bin/python"
vim.g.netrw_liststyle = 3

local options = {
    termguicolors = true,
    signcolumn = "yes",
    colorcolumn = "80",
    cursorline = true,
    scrolloff = 8,
    number = true,
    relativenumber = true,
    smartindent = true,
    wrap = false,
    expandtab = true,
    softtabstop = 4,
    tabstop = 4,
    shiftwidth = 4,
    hlsearch = false,
    incsearch = true,
    updatetime = 50,
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.opt.shortmess:append('c')
