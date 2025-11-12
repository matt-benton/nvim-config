return {
    -- { 'sheerun/vim-polyglot' }, -- improved language support (I tried to use this but I'm getting an error on startup when it is installed)
    {
        "stevearc/conform.nvim",
        opts = function()
            local opts = {
                formatters_by_ft = {
                    lua = { "stylua" },
                    php = { "pint" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            }
            return opts
        end,
    },
}
