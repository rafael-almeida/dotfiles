local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Opens help as a vertical split
autocmd("BufEnter", {
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd("wincmd L | vertical resize 80")
        end
    end
})

-- Prevents auto-comment on new line
autocmd("BufEnter", {
    pattern = "*",
    command = "set formatoptions-=o"
})

-- Disables cursorline for inactive buffers
local group = augroup("CursorLineControl", { clear = true })

autocmd("WinEnter", {
    group = group,
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

autocmd("WinLeave", {
    group = group,
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

autocmd("FileType", {
    group = group,
    callback = function()
        vim.opt_local.cursorline = false
    end,
    pattern = "TelescopePrompt"
})
-- end
