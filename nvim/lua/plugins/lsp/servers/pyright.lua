return {
    settings = {
        python = {
            analysis = {
                ignore = { "**/*" }, -- Disables linting; managed by Ruff. Pyright is used only for language server features (hover, go to definition, etc).
            },
        }
    },
}
