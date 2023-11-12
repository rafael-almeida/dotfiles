-- disable arrow keys
vim.keymap.set('n', '<Up>', '<nop>')
vim.keymap.set('n', '<Down>', '<nop>')
vim.keymap.set('n', '<Left>', '<nop>')
vim.keymap.set('n', '<Right>', '<nop>')

-- disable repeat the last recorded register
vim.keymap.set('n', 'Q', '<nop>')

-- toggle explorer
vim.keymap.set('n', '<leader>n', ':Exp<CR>')

-- make Y behave like it should
vim.keymap.set('n', 'Y', 'yg$')

-- make P behave like it should
vim.keymap.set('x', 'p', '"_dP')

-- copy to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')

-- paste from clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')

-- use black hole register
vim.keymap.set({ 'n', 'v' }, '<leader>x_', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>d_', '"_d')
vim.keymap.set({ 'n', 'v' }, '<leader>D_', '"_D')
vim.keymap.set({ 'n', 'v' }, '<leader>c_', '"_c')
vim.keymap.set({ 'n', 'v' }, '<leader>C_', '"_C')

-- replace word under cursor
vim.keymap.set('n', '<leader>s', ':%s/<C-r><C-w>//gI<Left><Left><Left>')

-- replace selection
vim.keymap.set('v', '<leader>s', '"zy:%s/<C-r>z//gI<Left><Left><Left>')

-- center cursor when moving page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- center cursor when searching
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- maintain cursor's position after line join
vim.keymap.set('n', 'J', 'mzJ`z')

-- indent line on single key press
vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')

-- maintain visual mode after indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- move line(s) up and down
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==g<Esc>')
vim.keymap.set('v', '<C-k>', ':m \'<-2<CR>gv=gv')
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==gi')

vim.keymap.set('n', '<C-j>', ':m .+1<CR>==g<Esc>')
vim.keymap.set('v', '<C-j>', ':m \'>+1<CR>gv=gv')
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==gi')

-- split windows
-- TODO: behaves incorrectly for more than 2 windows. 
-- When I open a third window, it navigates to the right most one, instead of the nearly created window
vim.keymap.set('n', '<C-W>s', ':split<CR><C-W><C-j><CR>')
vim.keymap.set('n', '<C-W>v', ':vsplit<CR><C-W><C-l><CR>')

-- navigate windows
vim.keymap.set('n', '<C-W>k', '<C-W><C-k>')
vim.keymap.set('n', '<C-W>j', '<C-W><C-j>')
vim.keymap.set('n', '<C-W>h', '<C-W><C-h>')
vim.keymap.set('n', '<C-W>l', '<C-W><C-l>')

-- navigate buffers
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<S-q>', ':bd<CR>')
