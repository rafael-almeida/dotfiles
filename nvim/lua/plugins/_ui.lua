vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'
vim.opt.number = true
vim.opt.relativenumber = true

local icons = require('config').icons

return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'night',
            on_highlights = function(h, c)
                h.BufferLineFill = {
                    bg = c.bg_dark
                }
            end
        },
        config = function(_, opts)
            require('tokyonight').load(opts)
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true }
        },
        event = 'VeryLazy',
        keys = {
            { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>' },
            { '<leader>bc', '<Cmd>BufferLineOthers<CR>' },
            { '<leader>bC', '<Cmd>BufferLineGroupClose ungrouped<CR>' },
            { '<leader>bg', ':BufferLineGoToBuffer ' },
        },
        opts = {
            options = {
                numbers = function(opts)
                    return opts.raise(opts.ordinal)
                end,
                indicator = {
                    style = 'icon',
                    icon = icons.tab_indicator,
                },
                diagnostics = 'nvim_lsp',
                diagnostics_indicator = function(count, _, diagnostics, context)
                    if context.buffer:current() then
                        return ''
                    end

                    local r = ''

                    if diagnostics['error'] then
                        r = r .. icons.error .. count .. ' '
                    end

                    if diagnostics['warning'] then
                        r = r .. icons.warn .. count .. ' '
                    end

                    return vim.trim(r)
                end,
                show_buffer_icons = false,
            },
        },
        config = function(_, opts)
            opts.options.groups = {
                items = {
                    require('bufferline.groups').builtin.pinned:with({ icon = icons.pin })
                },
            }

            require('bufferline').setup(opts)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true }
        },
        event = 'VeryLazy',
        opts = {
            options = { section_separators = '' },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'diagnostics',
                        symbols = {
                            error = icons.error,
                            warn = icons.warn,
                            info = icons.info,
                            hint = icons.hint
                        }
                    }
                },
                lualine_c = {
                    function ()
                        return require('pomodoro').get_remaining_time()
                    end
                },
                lualine_x = {
                    { 'filename', path = 1 },
                },
                lualine_y = { 'progress' },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    { 'filename', path = 1 },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            char = icons.indent_char,
            space_char_blankline = icons.blankline_char,
            show_current_context = true,
            use_treesitter = true,
        },
        init = function()
            vim.opt.list = true
            vim.opt.listchars:append('space:' .. icons.space_char)
            vim.opt.listchars:append('eol:' .. icons.newline_char)
        end,
    }
}
