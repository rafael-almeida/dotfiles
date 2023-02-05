vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use "hrsh7th/cmp-cmdline"
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lua'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = "nvim-lua/plenary.nvim"
    }

    use("mbbill/undotree")

    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    }

    use("tpope/vim-fugitive")
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    }

    use("lukas-reineke/indent-blankline.nvim")

    use("folke/tokyonight.nvim")
    use("tanvirtin/monokai.nvim")
end)
