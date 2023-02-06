require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "help",
        "lua",
        "javascript",
        "typescript",
        "python",
        "go",
        "html",
        "markdown",
        "json"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
}
