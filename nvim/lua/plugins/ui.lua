vim.opt.termguicolors = true

vim.g.netrw_banner = 0

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = { "80", "120" }
vim.opt.number = true
vim.opt.relativenumber = true

local icons = require("config").icons

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night",
            on_highlights = function(h, c)
                h.BufferLineFill = { bg = c.bg_dark }
                h.ColorColumn = { bg = c.bg_highlight }
                h.Whitespace = { fg = c.bg_highlight }
            end
        },
        config = function(_, opts)
            require("tokyonight").load(opts)
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "VeryLazy" },
        opts = {
            sections = {
                lualine_b = {
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.error,
                            warn = icons.diagnostics.warn,
                            info = icons.diagnostics.info,
                            hint = icons.diagnostics.hint
                        }
                    }
                },
                lualine_c = {},
                lualine_x = {
                    { "filename", path = 1 },
                },
            }
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "VeryLazy" },
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "bufferline: Toggle pin" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "bufferline: Close buffers to the left" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "bufferline: Close buffers to the right" },
            { "<leader>bc", "<Cmd>BufferLineCloseOthers<CR>",          desc = "bufferline: Close other buffers" },
            { "<leader>bC", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "bufferline: Close non-pinned buffers" },
        },
        opts = {
            options = {
               show_buffer_icons = false, -- Disables filetype icons
            },
        },
        config = function(_, opts)
            opts.options.groups = {
                items = {
                    require("bufferline.groups")
                        .builtin
                        .pinned:with({ icon = icons.pin }) -- Changes pin icon
                },
            }

            require("bufferline").setup(opts)
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = icons.thin_vert,     -- The default character is a thick vertical line
                tab_char = icons.thin_vert, -- The default character is a greater than symbol
            },
        },
        init = function()
            vim.opt.list = true
            vim.opt.listchars:append("space:" .. icons.space)
            vim.opt.listchars:append("trail:" .. icons.trail)
        end,
    },
}
