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

autocmd("BufRead", {
    desc = "Open Neotree on enter",
    once = true,
    callback = function()
        if not vim.g.neotree_opened then
            vim.cmd "Neotree show"
            vim.g.neotree_opened = true
        end
    end,
})

-- Prevents auto-comment on new line
autocmd("BufEnter", {
    pattern = "*",
    command = "set formatoptions-=o"
})

-- Disables cursorline for inactive buffers
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
