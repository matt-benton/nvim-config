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
                    "intelephense",
                    "lua_ls",
                    "stylua",
                    "vtsls",
                },
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- PHP
            vim.lsp.enable("intelephense", { capabilities = capabilities })

            -- Vue (hybrid mode) + TypeScript
            -- `vue_ls` requires a TS LSP client attached to the same buffer.
            -- The recommended setup is `vtsls` + `@vue/typescript-plugin`.
            local vue_language_server_path = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

            local vue_plugin = {
                name = "@vue/typescript-plugin",
                location = vue_language_server_path,
                languages = { "vue" },
                configNamespace = "typescript",
            }

            vim.lsp.config("vtsls", {
                capabilities = capabilities,
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = { vue_plugin },
                        },
                    },
                },
                filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
            })

            vim.lsp.config("vue_ls", {
                capabilities = capabilities,
            })

            vim.lsp.enable("vtsls")
            vim.lsp.enable("vue_ls")

            -- lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
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
