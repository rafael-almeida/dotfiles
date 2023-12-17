local M = {}

--- Sets a non-recursive and silent keymap.
--
-- @param mode string          The mode in which the keymap is set (e.g., 'n' for normal mode).
-- @param lhs  string          The left-hand side of the keymap; the key combination.
-- @param rhs  string|function The right-hand side of the keymap; the command to execute, or a Lua function.
-- @param opts table|nil       Additional options for the keymap.
local function noremap(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

M.noremap = noremap

return M
