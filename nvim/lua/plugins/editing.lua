return {
    {
        "stevearc/conform.nvim",
        enable = false,
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
            },
        },
        keys = {
            {
                "<leader>ft",
                function()
                    require("conform").format(
                        { async = true, lsp_fallback = true }
                    )
                end,
                desc = "conform: Format"
            },
        },
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
        },
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 15,
            })
        end
    },
}
