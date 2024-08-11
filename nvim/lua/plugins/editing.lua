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
}
