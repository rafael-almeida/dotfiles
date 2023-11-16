return {
    {
        -- TODO: This needs custom keybindings.
        -- I don't like the current workflow. At the very least, I want to be able to open the panel, and to easily navigate suggestions
        "github/copilot.vim",
    },
    {
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
            vim.g.vimwiki_global_ext = 0 -- Restricts vimwiki to the paths listed in `vimwiki_list`, i.e., don't treat all markdown files as part of vimwiki
            vim.g.vimwiki_list = {
                {
                    path = "~/vimwiki",
                    syntax = "markdown",
                    ext = ".md",
                },
            }
        end
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            {
                "<leader>u",
                function()
                    -- Toggles Undotree and set it as the current window (move the cursor)
                    vim.cmd("UndotreeToggle")
                    for _, win in pairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local buftype = vim.api.nvim_buf_get_option(buf, "filetype")

                        if buftype == "undotree" then
                            vim.api.nvim_set_current_win(win)
                            break
                        end
                    end
                end
            },
            desc = "undotree: Toggle Undotree",
        },
        config = function()
            vim.g.undotree_WindowLayout = 4 -- Moves undotree window to the right, and expand the diff window to full width
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", lazy = true },
        },
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            use_diagnostic_signs = true, -- Uses the signs defined in the lsp client
        },
        keys = {
            { "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>",  desc = "trouble: Toggle document diagnostics" },
            { "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "trouble: Toggle workspace diagnostics" },
            { "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>",              desc = "trouble: Toggle quickfix list" },
            { "<leader>xl", "<Cmd>TroubleToggle loclist<CR>",               desc = "trouble: Toggle location list" },
        },

    },
    {
        -- TODO: This seems to be the slowest plugin to load.
        "numToStr/Comment.nvim",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
        },
        event = { "BufRead", "BufNewFile" },
        config = function(_, opts)
            -- nvim-ts-context-commentstring sets the commentstring option based on the cursor location in the file.
            -- This is useful for files with many different sections, each with a different style for comments (Svelte, Vue, etc).
            local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")

            if ok and ts_context then
                opts.pre_hook = ts_context.create_pre_hook()
            end

            require("Comment").setup(opts)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "tpope/vim-surround",
    },
}
