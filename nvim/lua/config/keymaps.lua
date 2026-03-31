--- Set a non-recursive and silent keymap.
--
-- @param mode string          The mode in which the keymap is set (e.g., 'n' for normal mode).
-- @param lhs  string          The left-hand side of the keymap; the key combination.
-- @param rhs  string|function The right-hand side of the keymap; the command to execute, or a Lua function.
-- @param opts table|nil       Additional options for the keymap.
local noremap = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

local map = vim.keymap.set

---------------------------------------------------------------------------------------------------

-- Disable arrow keys
noremap("n", "<Up>", "<nop>")
noremap("n", "<Down>", "<nop>")
noremap("n", "<Left>", "<nop>")
noremap("n", "<Right>", "<nop>")

-- Ignore line break character when Yanking
noremap("n", "Y", "yg$")

-- Paste without replacing register
noremap("x", "p", '"_dP')

-- Copy to clipboard
noremap({ "n", "v" }, "<leader>y", '"+y')
noremap({ "n", "v" }, "<leader>Y", '"+Y')

-- Paste from clipboard
noremap({ "n", "v" }, "<leader>p", '"+p')
noremap({ "n", "v" }, "<leader>P", '"+P')

-- Delete to black hole register
noremap("v", "<C-_>", '"_d')

-- Replace word under cursor
noremap("n", "<leader>S", ":%s/<C-r><C-w>//gI<Left><Left><Left>", { silent = false })

-- Replace selection
noremap("v", "<leader>S", '"zy:%s/<C-r>z//gI<Left><Left><Left>', { silent = false })

-- TODO: See if I should use noremap for these keymaps.
-- Native commenting
map("n", "<C-/>", "gcc", { desc = "Toggle line comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })

-- Center cursor when moving page
noremap("n", "<C-d>", "<C-d>zz")
noremap("n", "<C-u>", "<C-u>zz")

-- Center cursor when searching
noremap("n", "n", "nzzzv")
noremap("n", "N", "Nzzzv")

-- Maintain cursor's position after line join
noremap("n", "J", "mzJ`z")

-- Indent line on single key press
noremap("n", "<", "<<")
noremap("n", ">", ">>")

-- Maintain visual mode after indent
noremap("v", "<", "<gv")
noremap("v", ">", ">gv")

-- TODO: Fix these keymaps after tmux-navigator.
-- Move lines up and down
-- noremap("n", "<C-k>", ":m .-2<cr>==g<Esc>")
-- noremap("v", "<C-k>", ":m \'<-2<cr>gv=gv")
-- noremap("i", "<C-k>", "<Esc>:m .-2<cr>==gi")
--
-- noremap("n", "<C-j>", ":m .+1<cr>==g<Esc>")
-- noremap("v", "<C-j>", ":m \'>+1<cr>gv=gv")
-- noremap("i", "<C-j>", "<Esc>:m .+1<cr>==gi")

-- Navigate buffers
noremap("n", "<S-h>", ":bprevious<cr>")
noremap("n", "<S-l>", ":bnext<cr>")
noremap("n", "<S-q>", ":bd<cr>")
