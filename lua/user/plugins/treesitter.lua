local parsers = {
    "css",
    "diff",
    "editorconfig",
    "gitignore",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "phpdoc",
    "scss",
    "sql",
    "typescript",
    "vue",
    "xml",
    "yaml",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = "main",
            },
        },
        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })
            treesitter.install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if not pcall(vim.treesitter.start, args.buf) then
                        return
                    end

                    local filetype = vim.bo[args.buf].filetype
                    local language = vim.treesitter.language.get_lang(filetype)
                    if language and vim.treesitter.query.get(language, "indents") then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local textobjects = {
                ["if"] = "@function.inner",
                ["af"] = "@function.outer",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
            }

            for mapping, capture in pairs(textobjects) do
                vim.keymap.set({ "x", "o" }, mapping, function()
                    select.select_textobject(capture, "textobjects")
                end)
            end
        end,
    },
}
