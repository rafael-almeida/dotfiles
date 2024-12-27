return {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "~/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
