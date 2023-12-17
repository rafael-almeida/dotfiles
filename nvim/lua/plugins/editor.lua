return {
    {
        -- This is useful for files with multiple sections, each with a different style for comments (Svelte, Vue, etc).
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "svelte" },
        opts = {
            enable_autocmd = false, -- Commentstring is trigger by Comment.nvim
        },
        config = function(_, opts)
            require("ts_context_commentstring").setup(opts)
            vim.g.skip_ts_context_commentstring_module = true
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            local c = {}

            local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
            if ok then
                c.pre_hook = ts_context_commentstring.get_commentstring
            end

            require("Comment").setup(c)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    {
        "tpope/vim-surround",
        event = { "BufRead", "BufNewFile" },
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufRead", "BufNewFile" },
        opts = {}
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
    },
    {
        "cshuaimin/ssr.nvim",
        keys = {
            {
                "<leader>sR",
                function()
                    require("ssr").open()
                end,
                mode = { "n", "x" },
                desc = "ssr: Start structural search and replace",
            },
        },
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
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "TroubleToggle", "Trouble" },
        keys = {
            { "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>",  desc = "trouble: Toggle document diagnostics" },
            { "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "trouble: Toggle workspace diagnostics" },
            { "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>",              desc = "trouble: Toggle quickfix list" },
            { "<leader>xl", "<Cmd>TroubleToggle loclist<CR>",               desc = "trouble: Toggle location list" },
        },
        opts = {
            use_diagnostic_signs = true, -- Uses the signs defined in the lsp client
        },
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
        init = function()
            vim.g.undotree_WindowLayout = 4 -- Moves undotree window to the right, and expand the diff window to full width
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        cmd = "SymbolsOutline",
        keys = {
            { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
        },
        opts = {}
    },
}
