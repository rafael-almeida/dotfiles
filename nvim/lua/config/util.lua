local FileEvent = { "BufReadPost", "BufNewFile", "BufWritePre" }

--- Set a non-recursive and silent keymap.
--
-- @param mode string          The mode in which the keymap is set (e.g., 'n' for normal mode).
-- @param lhs  string          The left-hand side of the keymap; the key combination.
-- @param rhs  string|function The right-hand side of the keymap; the command to execute, or a Lua function.
-- @param opts table|nil       Additional options for the keymap.
local function noremap(mode, lhs, rhs, opts)
    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end


--- Set a non-recursive and silent keymap in normal mode.
--
-- @param bufnr number          The buffer number in which the keymap is set.
-- @param lhs   string          The left-hand side of the keymap; the key combination.
-- @param rhs   string|function The right-hand side of the keymap; the command to execute, or a Lua function.
-- @param desc  string          The description of the keymap.
local nnoremap = function(bufnr, lhs, rhs, desc)
    local opts = { buffer = bufnr, remap = false, desc = desc }
    vim.keymap.set("n", lhs, rhs, opts)
end

--- Extend a table with another table or the result of a function.
--
-- @param tbl   table          The table to extend.
-- @param other table|function The table or function to extend the table with.
--
-- @return table The extended table.
-- @see vim.tbl_extend
-- @usage vim_tbl_extend({ a = 1 }, { b = 2 }) -- { a = 1, b = 2 }
-- @usage vim_tbl_extend({ a = 1 }, function() return { b = 2 } end) -- { a = 1, b = 2 }
local tbl_extend = function(tbl, other)
    if type(other) == "function" then
        return vim.tbl_extend("force", tbl, other())
    else
        return vim.tbl_extend("force", tbl, other)
    end
end

M = {
    FileEvent = FileEvent,
    noremap = noremap,
    nnoremap = nnoremap,
    tbl_extend = tbl_extend,
}

return M
