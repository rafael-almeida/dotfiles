return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
        { "nvim-tree/nvim-web-devicons" },
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>N",
            "<Cmd>Neotree toggle reveal<CR>",
            desc = "neotree: Toggle"
        }
    },
}
