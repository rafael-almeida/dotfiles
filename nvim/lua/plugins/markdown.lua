return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        keys = {
            { "<leader>cp", "<cmd>MarkdownPreviewToggle<CR>", desc = "markdown: Preview markdown" },
        },
    }

    -- {
    --     "lukas-reineke/headlines.nvim",
    --     dependencies = "nvim-treesitter/nvim-treesitter",
    --     ft = { "markdown" },
    --     config = true,
    -- },
    -- {
    --     "toppair/peek.nvim",
    --     build = "deno task --quiet build:fast",
    --     ft = { "markdown" },
    --     config = function()
    --         local peek = require("peek")
    --         vim.api.nvim_create_user_command("MarkdownPreview", function()
    --             if peek.is_open() then
    --                 peek.close()
    --             else
    --                 peek.open()
    --             end
    --         end, {})
    --     end,
    -- },
}
