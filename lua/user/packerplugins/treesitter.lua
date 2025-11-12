require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
        enable = true,
    },
    -- context_commentstring = {
    --     enable = true,
    -- },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["if"] = "@function.inner",
                ["af"] = "@function.outer",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
            },
        },
    },
})
