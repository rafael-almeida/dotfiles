return {
    'nvim-telescope/telescope.nvim',
    version = false,
    dependencies = {
        { 'nvim-lua/plenary.nvim',           lazy = true },
        { 'nvim-treesitter/nvim-treesitter', lazy = true },
        { 'nvim-tree/nvim-web-devicons',     lazy = true },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            lazy = true,
            build = 'make',
            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
    },
    keys = {
        { '<leader>ff', '<Cmd>Telescope find_files<CR>' },
        { '<leader>fs', '<Cmd>Telescope live_grep<CR>' },
        { '<leader>fw', '<Cmd>Telescope grep_string<CR>' },
        { '<leader>fb', '<Cmd>Telescope buffers<CR>' },
        { '<leader>fk', '<Cmd>Telescope keymaps<CR>' },
        { '<leader>fh', '<Cmd>Telescope help_tags<CR>' },

        { '<leader>gc', '<Cmd>Telescope git_commits<CR>' },
        { '<leader>gs', '<Cmd>Telescope git_status<CR>' },
    },
    opts = {
        defaults = {
            layout_config = {
                preview_width = 0.70,
                width = 0.90,
                height = 0.99,
            },
        },
    },
    config = function(_, opts)
        require('telescope').setup(opts)
    end,
}
