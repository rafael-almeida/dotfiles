return {
    "vimwiki/vimwiki",
    keys = {
        { "<leader>ww", ":vs | :VimwikiIndex<CR>",                  desc = "vimwiki: Open Vimwiki" },
        { "<leader>wi", ":vs | :VimwikiDiaryIndex<CR>",             desc = "vimwiki: Open Vimwiki diary" },
        { "<leader>wd", ":vs | :VimwikiMakeDiaryNote<CR>",          desc = "vimwiki: Create a new diary note for today" },
        { "<leader>wy", ":vs | :VimwikiMakeYesterdayDiaryNote<CR>", desc = "vimwiki: Create a new diary note for yesterday" },
        { "<leader>wt", ":vs | :VimwikiMakeTomorrowDiaryNote<CR>",  desc = "vimwiki: Create a new diary note for tomorrow" },
        {
            "<leader>wU",
            function()
                local filepath = vim.fn.expand("%:p")
                if string.match(filepath, "/diary/") then
                    vim.cmd("VimwikiDiaryGenerateLinks")
                else
                    vim.cmd("VimwikiGenerateLinks")
                end
            end,
            desc = "vimwiki: Generate links",
        },
    },
    init = function()
        -- Changes the syntax to Markdown
        vim.g.vimwiki_global_ext = 0     -- Restricts vimwiki to the paths listed in `vimwiki_list`, i.e., don't treat all markdown files as part of vimwiki
        vim.g.vimwiki_list = {
            {
                path = "~/vimwiki",
                syntax = "markdown",
                ext = ".md",
            },
        }
    end
}
