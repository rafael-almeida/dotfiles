return {
    -- {
    --     "github/copilot.vim",
    -- },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            filetypes = { ["*"] = true },
        },
        config = function(_, opts)
            require("copilot").setup(opts)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    },
}
