return {
    {
        "cshuaimin/ssr.nvim",
        keys = {
            {
                "<leader>sR",
                function()
                    require("ssr").open()
                end,
                mode = { "n", "x" },
                desc = "ssr: Start structural search and replace",
            },
        },
    },
    {
        "simrat39/symbols-outline.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        cmd = "SymbolsOutline",
        keys = {
            { "<leader>cs", "<cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
        },
        opts = {}
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        keys = {
            { "<leader>ri", ":IncRename ", desc = "Incremental Rename" },
        },
        opts = {}
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
            { "<leader>z", "<cmd>Twilight<CR>", desc = "twilight: Toggle Twilight" }
        },
    },
}
