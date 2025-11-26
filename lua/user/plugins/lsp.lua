return {
    { "hrsh7th/cmp-nvim-lsp" }, -- needed by nvim-cmp and nvim-lspconfig
    { "onsails/lspkind-nvim" }, -- needed by nvim-cmp and nvim-lspconfig

    -- Language server protocol
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Setup Mason to automatically install LSP servers
            require("mason").setup()
            require("mason-lspconfig").setup({
                -- automatic_enable = {
                -- 	exclude = {
                -- 		"ts_ls"
                -- 	}
                -- }
                automatic_installation = false,
                ensure_installed = {
                    "vue_ls",
                    "intelphense",
                    "lua-language-server",
                    "stylua",
                    "typescript-language-server",
                },
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- PHP
            vim.lsp.enable("intelephense", { capabilities = capabilities })

            -- typescript (needed for vue)
            vim.lsp.enable("ts_ls")

            -- vue
            -- lspconfig.vue_ls.setup({
            --     capabilities = capabilities,
            --     filetypes = { "vue" },
            -- })

            -- lua
            vim.lsp.enable("lua_ls")

            -- Keymaps
            vim.keymap.set("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
            vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
            vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
            vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
            vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
            vim.keymap.set("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = false,
                float = {
                    source = true,
                },
            })
        end,
    },
}
