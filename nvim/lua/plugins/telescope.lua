return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
        { "nvim-lua/plenary.nvim",                    lazy = true },                 -- Required
        { "nvim-tree/nvim-web-devicons",              lazy = true },                 -- Shows icons
        { "nvim-treesitter/nvim-treesitter",          lazy = true },                 -- Shows syntax highlighting in preview window
        { "nvim-telescope/telescope-fzf-native.nvim", lazy = true, build = "make" }, -- Improves sorting performance
    },
    keys = {
        -- Find
        { "<leader>fr", "<Cmd>Telescope resume<CR>",                 desc = "telescope: Open previous picker" },
        { "<leader>fh", "<Cmd>Telescope help_tags<CR>",              desc = "telescope: Search for help tags" },
        { "<leader>fk", "<Cmd>Telescope keymaps<CR>",                desc = "telescope: Search for keybindings" },
        { "<leader>ff", "<Cmd>Telescope find_files hidden=true<CR>", desc = "telescope: Search for files (includes hidden)" },
        { "<leader>fs", "<Cmd>Telescope live_grep<CR>",              desc = "telescope: Search for text" },
        { "<leader>fw", "<Cmd>Telescope grep_string<CR>",            desc = "telescope: Search for word under the cursor" },
        { "<leader>fp", "<Cmd>Telescope lsp_document_symbols<CR>",   desc = "telescope: Search for symbols in current buffer" },
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
            -- path_display = { "smart" }, -- Removes as much from the path as possible to only show (might impact performance)
            -- path_display = { shorten = 4 }, -- Shows only the first 4 characters of each directory
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end,
}
