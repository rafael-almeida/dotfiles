-- Last reviewed on 2024-12-30
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
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<leader>ga",
                "<cmd>Gitsigns stage_hunk<cr>",
                desc = "gitsigns: Stage hunk",
            },
        },
        opts = {},
    },
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            -- These keymaps are used by Telescope:
            -- { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "telescope: List git commits" },
            -- { "<leader>gs", "<cmd>Telescope git_status<cr>",  desc = "telescope: List git status" },
            { "<leader>gg", "<cmd>Git<cr>",         desc = "View git status" },
            { "<leader>gp", "<cmd>Git pull<cr>",    desc = "Pull from remote repository" },
            { "<leader>gP", "<cmd>Git push<cr>",    desc = "Push changes to remote repository" },
            { "<leader>gA", "<cmd>Git add %<cr>",   desc = "Stage current file" },
            { "<leader>gb", "<cmd>Git blame<cr>",   desc = "Show git blame for current file" },
            { "<leader>gl", "<cmd>Git log<cr>",     desc = "View git commit log" },
            { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Open git diff tool" },
        },
    },

    -- TODO: Decide if this is being used:
    -- {
    --     "sindrets/diffview.nvim",
    --     cmd = "DiffviewOpen",
    --     keys = function()
    --         local is_open = false
    --         return {
    --             {
    --                 "<leader>gd",
    --                 function()
    --                     if is_open then
    --                         vim.cmd("DiffviewClose")
    --                     else
    --                         vim.cmd("DiffviewOpen")
    --                     end
    --                     is_open = not is_open
    --                 end,
    --                 desc = "diffview: Toggle DiffView"
    --             },
    --         }
    --     end,
    --     opts = {
    --         file_panel = {
    --             win_config = {
    --                 width = 30,
    --             },
    --         }
    --     },
    -- },

    -- TODO: Decide if this is being used:
    -- {
    --     "rhysd/git-messenger.vim",
    --     cmd = "GitMessenger",
    --     keys = {
    --         {
    --             "<leader>gh",
    --             "<cmd>GitMessenger<cr>",
    --             desc = "git-messenger: Show commit message for the current line",
    --         },
    --     },
    -- },

    {
        "stevearc/oil.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" }
        },
        cmd = "Oil",
        -- init = function()
        --     --- Disables netrw.
        --     vim.g.loaded_netrw = 1
        --     vim.g.loaded_netrwPlugin = 1
        -- end,
        opts = {},
        keys = {
            {
                "<leader>n",
                function()
                    require("oil").toggle_float()
                end,
                desc = "oil: Toggle floating window",
            },
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
            window = {
                width = 30,
            }
        },
        keys = {
            {
                "<leader>N",
                "<cmd>Neotree toggle<cr>",
                desc = "neotree: Toggle sidebar",
            }
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
            { "<leader>fr", "<cmd>Telescope resume<cr>",                 desc = "telescope: Open previous picker" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",              desc = "telescope: Search for help tags" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",                desc = "telescope: Search for keybindings" },
            { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "telescope: Search for files (includes hidden)" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>",              desc = "telescope: Search for text" },
            { "<leader>fw", "<cmd>Telescope grep_string<cr>",            desc = "telescope: Search for word under the cursor" },
            { "<leader>fp", "<cmd>Telescope lsp_document_symbols<cr>",   desc = "telescope: Search for symbols in current buffer" },
            { "<leader>fv", "<cmd>Telescope vim_options<cr>",            desc = "telescope: Search for vim options" },
            -- Git
            { "<leader>gc", "<cmd>Telescope git_commits<cr>",            desc = "telescope: List git commits" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>",             desc = "telescope: List git status" },
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
        -- TODO: Customize plugin
        -- TODO: Render vimwiki files
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-tree/nvim-web-devicons" }
        },
        ft = { "markdown" },
        opts = {
            heading = {
                sign = false,
                position = "inline",
                icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
            },
            link = {
                enabled = false,
            },
            bullet = {
                icons = { "─" }
            }
        },
    },
    {
        -- TODO: Search alternatives that do not require deno.
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        ft = "markdown",
        opts = {
            theme = "light",
        },
        config = function(_, opts)
            local peek = require("peek")
            peek.setup(opts)
            vim.api.nvim_create_user_command("PeekToggle", function()
                if peek.is_open() then
                    peek.close()
                else
                    peek.open()
                end
            end, {})
        end,
    },
    {
        -- TODO: Decide if this is being used:
        "vimwiki/vimwiki",
        keys = {
            { "<leader>ww", ":vs | :VimwikiIndex<cr>",                  desc = "vimwiki: Open Vimwiki" },
            { "<leader>wi", ":vs | :VimwikiDiaryIndex<cr>",             desc = "vimwiki: Open Vimwiki diary" },
            { "<leader>wd", ":vs | :VimwikiMakeDiaryNote<cr>",          desc = "vimwiki: Create a new diary note for today" },
            { "<leader>wy", ":vs | :VimwikiMakeYesterdayDiaryNote<cr>", desc = "vimwiki: Create a new diary note for yesterday" },
            { "<leader>wt", ":vs | :VimwikiMakeTomorrowDiaryNote<cr>",  desc = "vimwiki: Create a new diary note for tomorrow" },
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
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        keys = {
            {
                "<leader>ri",
                ":IncRename ",
                desc = "Incremental Rename",
            },
        },
        opts = {}
    },
    {
        "folke/twilight.nvim",
        cmd = "Twilight",
        opts = {
            dimming = {
                alpha = 0.35,
                inactive = true, -- Dims other windows.
            },
        },
        keys = {
            {
                "<leader>z",
                "<cmd>Twilight<cr>",
                desc = "twilight: Toggle Twilight",
            }
        },
    },
    -- {
    --     -- NOTE: Deprecated.
    --     "simrat39/symbols-outline.nvim",
    --     dependencies = {
    --         { "neovim/nvim-lspconfig" }
    --     },
    --     cmd = "SymbolsOutline",
    --     keys = {
    --         {
    --             "<leader>cs",
    --             "<cmd>SymbolsOutline<cr>",
    --             desc = "Symbols Outline",
    --         },
    --     },
    --     opts = {}
    -- },
}
