return {
    {
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                dependencies = {
                    { "nvim-treesitter/nvim-treesitter" }
                },
                opts = {
                    enable_autocmd = false,
                },
            },
        },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            pre_hook = function()
                require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            end
        }
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        opts = {}
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" }
        },
        ft = { "astro", "glimmer", "handlebars", "html", "javascript", "jsx", "markdown", "php", "rescript", "svelte", "tsx", "twig", "typescript", "vue", "xml" },
        opts = {}
    },
    {
        "tpope/vim-surround",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "Wansmer/treesj",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" }
        },
        opts = {
            max_join_length = 9999,
        },
        keys = {
            {
                "<leader>m",
                function()
                    require("treesj").toggle()
                end,
                desc = "treesj: Toggle between single-line and multi-line",
            },
            {
                "<leader>M",
                function()
                    require("treesj").toggle({
                        split = {
                            recursive = true,
                        },
                    })
                end,
                desc = "treesj: Toggle between single-line and multi-line (recursively)",
            },
        },
    },
    {
        "MagicDuck/grug-far.nvim",
        cmd = "GrugFar",
        opts = {},
        keys = {
            {
                "<leader>sr",
                "<cmd>GrugFar<cr>",
                desc = "grug-far: Search and Replace"
            }
        }
    },
    {
        "stevearc/oil.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" }
        },
        cmd = "Oil",
        init = function()
            --- disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {},
        keys = {
            {
                "<leader>n",
                function()
                    require("oil").toggle_float()
                end,
                desc = "oil: Toggle floating window",
            },
            -- {
            --     "<leader>n",
            --     function()
            --         require("oil").open()
            --     end,
            --     desc = "oil: Open current directory",
            -- }
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "MunifTanjim/nui.nvim" },
            { "nvim-tree/nvim-web-devicons" },
        },
        cmd = "Neotree",
        opts = {
            close_if_last_window = true, -- This is highly desirable.
            filesystem = {
                filtered_items = {
                    visible = true,
                    never_show = {
                        ".git",
                        "node_modules",
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
        },
        keys = {
            {
                "<leader>N",
                "<cmd>Neotree toggle float<CR>",
                desc = "neotree: Toggle sidebar",
            },
            -- {
            --     "<leader>N",
            --     "<cmd>Neotree toggle<CR>",
            --     desc = "neotree: Toggle sidebar",
            -- }
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-tree/nvim-web-devicons" },
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
                path_display = { "truncate" }, -- Shows as much of the path as possible.
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end,
        keys = {
            -- Find
            { "<leader>fr", "<cmd>Telescope resume<CR>",                 desc = "telescope: Open previous picker" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",              desc = "telescope: Search for help tags" },
            { "<leader>fk", "<cmd>Telescope keymaps<CR>",                desc = "telescope: Search for keybindings" },
            { "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", desc = "telescope: Search for files (includes hidden)" },
            { "<leader>fs", "<cmd>Telescope live_grep<CR>",              desc = "telescope: Search for text" },
            { "<leader>fw", "<cmd>Telescope grep_string<CR>",            desc = "telescope: Search for word under the cursor" },
            { "<leader>fp", "<cmd>Telescope lsp_document_symbols<CR>",   desc = "telescope: Search for symbols in current buffer" },
            { "<leader>fv", "<cmd>Telescope vim_options<CR>",            desc = "telescope: Search for vim options" },
            -- Git
            { "<leader>gc", "<cmd>Telescope git_commits<CR>",            desc = "telescope: List git commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>",             desc = "telescope: List git status" },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        cmd = "Trouble",
        opts = {},
        keys = {
            {
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "trouble: Toggle document diagnostics",
            },
            {
                "<leader>xw",
                "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
                desc = "trouble: Toggle workspace diagnostics",
            },
            {
                "<leader>xl",
                "<cmd>Trouble loclist toggle focus=true<cr>",
                desc = "trouble: Toggle quickfix list",
            },
            {
                "<leader>xq",
                "<cmd>Trouble qflist toggle focus=true<cr>",
                desc = "trouble: Toggle location list",
            },
        },
    },
    {
        -- TODO: Persist undo history.
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            {
                "<leader>u",
                function()
                    vim.cmd("UndotreeToggle")
                    require("config.util").go_to_win_of_type("undotree")
                end
            },
            desc = "undotree: Toggle Undotree",
        },
        init = function()
            vim.g.undotree_WindowLayout = 4 --  Positions the undotree window on the right and sets the diff window to full width.
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" }
        },
        opts = {
            signs = false,
            highlight = {
                keyword = "fg",
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
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
            vim.g.vimwiki_list = {
                { path = "~/vimwiki", syntax = "markdown", ext = ".md" }, -- Changes the syntax to Markdown.
            }
            vim.g.vimwiki_global_ext = 0                                  -- Restricts vimwiki to the paths listed in `vimwiki_list`, i.e., don't treat all markdown files as part of vimwiki.
        end
    },
}
