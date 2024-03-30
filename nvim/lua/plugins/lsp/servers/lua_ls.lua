return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    "vim" -- Fixes `Undefined global "vim"` warning.
                },
                disable = {
                    "missing-fields" -- Disables `Undefined field` warning. This warning shows up often when using neodev.
                },
            },
            format = {
                defaultConfig = {
                    quote_style = "double",
                }
            }
        }
    }
}
