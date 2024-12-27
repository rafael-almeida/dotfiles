-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    -- {
    --     dir = "/Users/rafael/development/jupyter-nvim",
    -- },
    {
        -- TODO: Make signs consistent with LSP
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "MunifTanjim/nui.nvim" },
            { "nvim-tree/nvim-web-devicons" },
        },
        cmd = "Neotree",
        opts = {
            hijack_netrw_behavior = "open_default",
            add_blank_line_at_top = true,
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    -- hide_dotfiles = false,
                    -- hide_gitignored = false,
                    never_show = { "node_modules" },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
            window = {

                width = 25,
            }
        },
        keys = {
            {
                "<leader>N",
                "<Cmd>Neotree toggle float reveal<CR>",
                desc = "neotree: Toggle",
            }
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        version = false,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        cmd = "Telescope",
        opts = {
            defaults = {
                layout_config = {
                    preview_width = 0.70,
                    width = 0.95,
                    height = 0.99,
                },
                file_ignore_patterns = { ".git" },
                path_display = { "truncate" }, -- Shows as much of the path as possible
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end,
        keys = {
            -- Find
            { "<leader>fr", "<Cmd>Telescope resume<CR>",                 desc = "telescope: Open previous picker" },
            { "<leader>fh", "<Cmd>Telescope help_tags<CR>",              desc = "telescope: Search for help tags" },
            { "<leader>fk", "<Cmd>Telescope keymaps<CR>",                desc = "telescope: Search for keybindings" },
            { "<leader>ff", "<Cmd>Telescope find_files hidden=true<CR>", desc = "telescope: Search for files (includes hidden)" },
            { "<leader>fs", "<Cmd>Telescope live_grep<CR>",              desc = "telescope: Search for text" },
            { "<leader>fw", "<Cmd>Telescope grep_string<CR>",            desc = "telescope: Search for word under the cursor" },
            { "<leader>fp", "<Cmd>Telescope lsp_document_symbols<CR>",   desc = "telescope: Search for symbols in current buffer" },
            { "<leader>fv", "<Cmd>Telescope vim_options<CR>",            desc = "telescope: Search for vim options" },
            -- Git
            { "<leader>gc", "<Cmd>Telescope git_commits<CR>",            desc = "telescope: List git commits" },
            { "<leader>gs", "<Cmd>Telescope git_status<CR>",             desc = "telescope: List git status" },
        },
    },
    {
        -- NOTE: This plugin has a v3 beta
        -- TODO: Make signs consistent with LSP
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            { "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>",  desc = "trouble: Toggle document diagnostics" },
            { "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "trouble: Toggle workspace diagnostics" },
            { "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>",              desc = "trouble: Toggle quickfix list" },
            { "<leader>xl", "<Cmd>TroubleToggle loclist<CR>",               desc = "trouble: Toggle location list" },
        },
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            {
                "<leader>u",
                function()
                    -- Toggles Undotree and set it as the current buffer
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
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                ft = { "vue", "svelte", "javascriptreact", "typescriptreact" },
                opts = {
                    enable_autocmd = false,
                },
            },
        },
        event = { "BufRead", "BufNewFile" },
        opts = {
            pre_hook = function(ctx)
                return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
            end,
        }
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufRead", "BufNewFile" },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml", "markdown" },
        config = true,
    },
    {
        "tpope/vim-surround",
        event = { "BufRead", "BufNewFile" },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                keyword = "fg",
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
    }
}
