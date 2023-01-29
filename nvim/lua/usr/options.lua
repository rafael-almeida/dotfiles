vim.g.mapleader = " "

local options = {
    termguicolors = true,
    signcolumn = "yes",
    colorcolumn = "80",
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
