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
                format_on_save = function(bufnr)
                    -- Disable formatting on save for Vue files.
                    if vim.bo[bufnr].filetype == "vue" then
                        return {
                            timeout_ms = 500,
                            lsp_format = "never",
                        }
                    end

                    -- Otherwise, use LSP formatting only when no other formatter is configured.
                    return {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end,
            }
            return opts
        end,
    },
}
