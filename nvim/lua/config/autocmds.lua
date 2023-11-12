local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- Open help as a vertical split
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd("wincmd L | vertical resize 80")
        end
    end
})

-- TODO: don't show line number in netrw

-- open `help` as a vertical split
-- This only work when execution `:help` for the first time. All consecutive `:help` will open in horizontal split
autocmd("FileType", {
    pattern = "help",
    command = "wincmd L | vert resize 90"
})

-- don't insert comment after 'o' or 'O'
autocmd("BufEnter", {
    pattern = "*",
    command = "set formatoptions-=o"
})

--  disable cursorline for inactive buffers
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
