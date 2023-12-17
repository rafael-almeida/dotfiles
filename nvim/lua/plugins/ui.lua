vim.opt.termguicolors = true

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
                h.ColorColumn = { bg = "#2d3149" }
            end
        },
        config = function(_, opts)
            require("tokyonight").load(opts)
        end,
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", lazy = true }
        },
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "bufferline: Toggle pin" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "bufferline: Close buffers to the left" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "bufferline: Close buffers to the right" },
            { "<leader>bc", "<Cmd>BufferLineCloseOthers<CR>",          desc = "bufferline: Close other buffers" },
            { "<leader>bC", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "bufferline: Close non-pinned buffers" },
        },
        opts = {
            options = {
                -- numbers = function(opts)
                --     return opts.raise(opts.ordinal) -- Shows tab number as superscript
                -- end,
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
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons", lazy = true }
        },
        event = "VeryLazy",
        opts = {
            -- options = {
            --     section_separators = ""
            -- },
            sections = {
                lualine_b = {
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.error,
                            warn = icons.warn,
                            info = icons.info,
                            hint = icons.hint
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
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {
            indent = {
                char = icons.thin_vert,     -- The default character is a thick vertical line
                tab_char = icons.thin_vert, -- The default character is a greater than symbol
            },
        },
        -- init = function()
        --     vim.opt.list = true
        --     vim.opt.listchars:append("space:" .. icons.space_char)
        --     vim.opt.listchars:append("eol:" .. icons.newline_char)
        -- end,
    },
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim" },
        },
        keys = {
            { "<leader>m", "<Cmd>WindowsMaximize<CR>", desc = "windows: Zoom" }
        },
        config = function()
            vim.o.winwidth = 5
            vim.o.equalalways = false
            require("windows").setup()
        end,
    },
    {
        "folke/twilight.nvim",
        cmd = "Twilight",
        opts = {
            dimming = {
                alpha = 0.35,
                inactive = true, -- Dims other windows
            },
        },
        keys = {
            { "<leader>z", "<Cmd>Twilight<CR>", desc = "twilight: Toggle Twilight" }
        },
    },
}
