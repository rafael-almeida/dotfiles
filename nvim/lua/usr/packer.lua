-- Run PackerCompile on save
vim.cmd [[
   augroup packer_user_config
     autocmd!
     autocmd BufWritePost packer.lua source <afile> | PackerCompile
   augroup end
]]

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Telescope
    -- ====================================================================

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim"
    })

    -- Treesitter
    -- ====================================================================

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_install = require("nvim-treesitter.install")
            local ts_update = ts_install.update({ with_sync = true })
            ts_update()
        end,
    })

    -- LSP + CMP + NULL-LS
    -- ====================================================================

    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("saadparwaiz1/cmp_luasnip")

    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim"
    })

    -- DAP
    -- ====================================================================

    use("mfussenegger/nvim-dap")

    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" }
    })

    use({
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    })

    use({
        "nvim-telescope/telescope-dap.nvim",
        requires = {
            "mfussenegger/nvim-dap",
            "nvim-telescope/telescope.nvim",
            { "nvim-treesitter/nvim-treesitter", opt = true },
        },
        config = function()
            require('telescope').load_extension('dap')
        end
    })

    use({
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        end
    })

    use({
        "leoluz/nvim-dap-go",
        config = function()
            require('dap-go').setup()
        end
    })

    -- Trouble
    -- ====================================================================
    use {
        "folke/trouble.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function()
            require("trouble").setup()
        end
    }

    -- Git
    -- ====================================================================

    use("tpope/vim-fugitive")
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }

    -- Undotree
    -- ====================================================================

    use("mbbill/undotree")

    -- VimWiki
    -- ====================================================================

    use("vimwiki/vimwiki")

    -- Editing
    -- ====================================================================

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    })
    use("tpope/vim-surround")

    -- Multi cursors
    -- ====================================================================

    use("mg979/vim-visual-multi")

    -- UI
    -- ====================================================================

    -- TODO: multiple unused themes
    use("rafi/awesome-vim-colorschemes")
    use("lukas-reineke/indent-blankline.nvim")
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function()
            require('lualine').setup()
        end
    })
end)
