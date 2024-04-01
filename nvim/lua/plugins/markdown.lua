return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        cmd = "MarkdownPreviewToggle",
        keys = {
            { "<leader>cp", "<Cmd>MarkdownPreviewToggle<CR>", desc = "markdown: Preview markdown" },
        },
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
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
