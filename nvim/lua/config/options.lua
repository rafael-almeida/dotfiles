vim.g.netrw_banner = 0

--vim.g.python3_host_prog = '~/.virtualenvs/neovim/bin/python'

local options = {
    scrolloff = 10,
    splitright = true,
    splitbelow = true,
    wrap = false,
    smartindent = true,
    expandtab = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    hlsearch = false,
    swapfile = false,
    undofile = true,
    --updatetime = 50,
    --undodir = os.getenv('HOME') .. '/.vim/undodir',
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
