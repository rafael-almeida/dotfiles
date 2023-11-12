return {
    {
        "github/copilot.vim"
    },
    {
        'vimwiki/vimwiki',
        keys = {
            {
                '<leader>wU',
                function()
                    local filepath = vim.fn.expand('%:p')
                    if string.match(filepath, '/diary/') then
                        vim.cmd('VimwikiDiaryGenerateLinks')
                    else
                        vim.cmd('VimwikiGenerateLinks')
                    end
                end,
            },
            { '<leader>ww', ':vs | :VimwikiIndex<CR>' },
            { '<leader>wi', ':vs | :VimwikiDiaryIndex<CR>' },
            { '<leader>wd', ':vs | :VimwikiMakeDiaryNote<CR>' },
            { '<leader>wy', ':vs | :VimwikiMakeYesterdayDiaryNote<CR>' },
            { '<leader>wt', ':vs | :VimwikiMakeTomorrowDiaryNote<CR>' },
        },
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/vimwiki',
                    syntax = 'markdown',
                    ext = '.md',
                },
            }

            vim.g.vimwiki_ext2syntax = {
                ['.md'] = 'markdown',
                ['.markdown'] = 'markdown',
                ['.mdown'] = 'markdown',
            }

            vim.g.vimwiki_global_ext = 0
        end
    },
    {
        'mbbill/undotree',
        cmd = { 'UndotreeToggle' },
        keys = {
            { '<leader>u', '<Cmd>UndotreeToggle<CR>' },
        },
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true }, -- TODO: This might not be needed. I think I could be okay with not having icons.
        },
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = {
            use_diagnostic_signs = true,
        },
        keys = {
            { '<leader>xd', '<Cmd>TroubleToggle document_diagnostics<CR>' },
            { '<leader>xw', '<Cmd>TroubleToggle workspace_diagnostics<CR>' },
            { '<leader>xq', '<Cmd>TroubleToggle quickfix<CR>' },
            { '<leader>xl', '<Cmd>TroubleToggle loclist<CR>' },
        },
    },
    {
        'numToStr/Comment.nvim',
        dependencies = {
            { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
        },
        event = { 'BufRead', 'BufNewFile' },
        config = function(_, opts)
            local ok, ts_context = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')

            if ok and ts_context then
                opts.pre_hook = ts_context.create_pre_hook()
            end

            require('Comment').setup(opts)
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter' },
        config = function()
            require('nvim-autopairs').setup()
        end,
    },
    {
        'tpope/vim-surround',
    },
}
