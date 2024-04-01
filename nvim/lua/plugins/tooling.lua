return {
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
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    -- {
    --     "toppair/peek.nvim",
    --     build = "deno task --quiet build:fast",
    --     ft = { "markdown" },
    --     config = function()
    --         local peek = require("peek")
    --         vim.api.nvim_create_user_command("MarkdownPreview", function()
    --             if peek.is_open() then
    --                 peek.close()
    --             else
    --                 peek.open()
    --             end
    --         end, {})
    --     end,
    -- },
}
