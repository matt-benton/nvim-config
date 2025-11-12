local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    -- My plugins here
    -- use 'foo1/bar1.nvim'
    -- use 'foo2/bar2.nvim'
    use("tpope/vim-commentary") -- enhanced commenting
    use("JoosepAlviste/nvim-ts-context-commentstring") -- helps commenting in files with multiple languages (such as vue sfc)
    use("tpope/vim-surround") -- modify surrounding text
    use("tpope/vim-repeat") -- allow plugins to enable repeating of commands
    use("tpope/vim-sleuth") -- indent autodetect with editorconfig support
    use("sheerun/vim-polyglot") -- improved language support
    use("farmergreg/vim-lastplace") -- remember last place when opening a file
    use("nelstrom/vim-visual-star-search") -- enable * searching with visually selected text
    use("ku1ik/vim-pasta") -- automatically indent when pasting into vim
    -- text objects for xml attributes
    use({
        "whatyouhide/vim-textobj-xmlattr",
        requires = "kana/vim-textobj-user",
    })
    -- smooth scrolling when jumping around
    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })

    -- split arrays or objects on multiple lines, or join them back up
    use({
        "AndrewRadev/splitjoin.vim",
        config = function()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_chain_full = 1
        end,
    })

    -- github color scheme
    -- use({
    --   'projekt0n/github-nvim-theme',
    --   config = function()
    --     require('github-theme').setup({
    --       -- ...
    --     })

    --     vim.cmd('colorscheme github_dark')
    --   end
    -- })

    use({
        "fneu/breezy",
        config = function()
            vim.cmd("colorscheme breezy") -- change the color scheme
            vim.cmd("hi! LineNr guibg=none") -- change the background of line numbers
            vim.cmd("highlight SignColumn guibg=none") -- change the background of the margin to the left of line numbers

            vim.cmd("highlight TabLine guibg=none") -- change background color of inactive tabs
            -- vim.cmd('highlight TabLineSel guibg=none') -- change color for actice tabs
            vim.cmd("highlight TabLineFill guibg=none") -- change color of rest of tabline

            vim.cmd("highlight VertSplit guibg=none") -- change the background color of splits
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        -- or                            , branch = '0.1.x',
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "kyazdani42/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = function()
            require("user/plugins/telescope")
        end,
    })

    use({
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<Leader>fi", ":NvimTreeToggle<CR>")
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("user/plugins/lualine")
        end,
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>")
            vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>")
            vim.keymap.set("n", "gp", ":Gitsigns preview_hunk<CR>")
            vim.keymap.set("n", "gb", ":Gitsigns blame_line<CR>")
        end,
    })

    use({
        "voldikss/vim-floaterm",
        config = function()
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
            vim.g.floaterm_title = ""
            vim.g.floaterm_borderchars = ""
            vim.keymap.set("n", "<Leader>ft", ":FloatermToggle<CR>")
            vim.cmd([[
        highlight link FloatermBorder CursorLine
        highlight link Floaterm CursorLine
      ]])
        end,
    })

    -- Improved syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("user.plugins.treesitter")
        end,
    })

    require("nvim-treesitter.configs").setup({})

    -- Language server protocol
    use({
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("user/plugins/lspconfig")
        end,
    })

    -- Completion
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
        config = function()
            require("user/plugins/cmp")
        end,
    })

    -- Testing helper
    use({
        "vim-test/vim-test",
        config = function()
            require("user/plugins/vim-test")
        end,
    })

    use({
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                -- config
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                },
            })
        end,
        requires = { "nvim-tree/nvim-web-devicons" },
    })

    use({
        "gcmt/vessel.nvim",
        config = function()
            require("vessel").setup({
                create_commands = true,
                commands = {
                    view_marks = "Marks",
                    view_jumps = "Jumps",
                    view_buffers = "Buffers",
                },
                vim.keymap.set("n", "gm", "<plug>(VesselSetGlobalMark)"),
            })
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])
