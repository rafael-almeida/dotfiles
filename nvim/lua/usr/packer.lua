vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
        use("wbthomason/packer.nvim")

        -- LSP
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

        -- Treesitter
        -- ====================================================================

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        })

        -- Telescope
        -- ====================================================================

        use({
            "nvim-telescope/telescope.nvim",
            tag = "0.1.1",
            requires = "nvim-lua/plenary.nvim"
        })

        -- DAP
        -- ====================================================================

        use("mfussenegger/nvim-dap")
        use("mfussenegger/nvim-dap-python")
        use("leoluz/nvim-dap-go")
        use("theHamsta/nvim-dap-virtual-text")
        use("nvim-telescope/telescope-dap.nvim")
        use({
            "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap" }
        })

        -- Git
        -- ====================================================================

        use("tpope/vim-fugitive")
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end
        }

        -- Undotree
        -- ====================================================================

        use("mbbill/undotree")

        -- VimWiki
        -- ====================================================================

        use("vimwiki/vimwiki")

        -- Multi cursors
        -- ====================================================================

        use("mg979/vim-visual-multi")

        -- Editing
        -- ====================================================================

        use("numToStr/Comment.nvim")
        use("windwp/nvim-autopairs")
        use("tpope/vim-surround")

        -- UI
        -- ====================================================================

        use("rafi/awesome-vim-colorschemes")
        use("lukas-reineke/indent-blankline.nvim")
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true }
        })
    end)
