local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Open Neotree on startup
autocmd("BufRead", {
    once = true,
    callback = function()
        if not vim.g.neotree_opened then
            vim.cmd "Neotree show"
            vim.g.neotree_opened = true
        end
    end,
})

-- Open help as a vertical split
autocmd("BufEnter", {
    pattern = "*.txt",
    callback = function()
        if vim.bo.buftype == "help" then
            vim.cmd("wincmd L | vertical resize 80")
        end
    end
})

-- Set indentation for JS/TS files
autocmd("FileType", {
    pattern = "javascript,typescript,javascriptreact,typescriptreact",
    command = "setlocal shiftwidth=2 softtabstop=2"
})

-- Prevent auto-comment on new line
autocmd("BufEnter", {
    pattern = "*",
    command = "set formatoptions-=o"
})

-- Disable cursorline on inactive buffers
-- start
augroup("CursorLineControl", { clear = true })

autocmd("WinEnter", {
    group = "CursorLineControl",
    callback = function()
        vim.opt_local.cursorline = true
    end,
})

autocmd("WinLeave", {
    group = "CursorLineControl",
    callback = function()
        if vim.bo.filetype ~= "neo-tree" then
            vim.opt_local.cursorline = false
        end
    end,
})

autocmd("FileType", {
    group = "CursorLineControl",
    pattern = "TelescopePrompt",
    callback = function()
        vim.opt_local.cursorline = false
    end,
})
-- end
