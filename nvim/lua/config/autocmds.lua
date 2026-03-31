local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position on file open
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- TODO: See if this can be accomplished in a more efficient way.
-- Prevent auto-comment on new line
autocmd("BufEnter", {
  pattern = "*",
  command = "set formatoptions-=o"
})

-- Auto-reload files changed on disk
vim.fn.timer_start(1000, function()
  vim.cmd("silent! checktime")
end, { ["repeat"] = -1 })

-- TODO: See if this is needed.
-- Auto-resize splits on terminal resize
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
