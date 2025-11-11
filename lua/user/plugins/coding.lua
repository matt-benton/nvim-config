return {
    { "sheerun/vim-polyglot" }, -- extended language support (needed for blade files)
    { 'tpope/vim-surround' }, -- modify surrounding text
    { 'tpope/vim-repeat' }, -- allow plugins to enable repeating of commands
    { 'nelstrom/vim-visual-star-search' }, -- enable * searching with visually selected text
    { 'ku1ik/vim-pasta' }, -- automatically indent when pasting into vim
    { 'whatyouhide/vim-textobj-xmlattr', dependencies = 'kana/vim-textobj-user' }, -- text objects for xml attributes
    {
      'AndrewRadev/splitjoin.vim', -- split arrays or objects on multiple lines, or join them back up
      config = function()
	      vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
	      vim.g.splitjoin_trailing_comma = 1
	      vim.g.splitjoin_php_method_chain_full = 1
      end,
    },
    {
	    "L3MON4D3/LuaSnip", -- used for snippets
	    -- follow latest release.
	    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	    -- install jsregexp (optional!).
	    build = "make install_jsregexp"
    },
		{ 'saadparwaiz1/cmp_luasnip' }, -- nvim-cmp needs this
		{
		  'gcmt/vessel.nvim', -- show marks in popup and get mark letter automatically
		  config = function()
		    require("vessel").setup({
		      create_commands = true,
		      commands = {
						view_marks = "Marks",
						view_jumps = "Jumps",
						view_buffers = "Buffers"
		      },
		      vim.keymap.set('n', 'gm', '<plug>(VesselSetGlobalMark)')
		    })
		  end,
	{
  "gisketch/triforce.nvim",
  dependencies = {
    "nvzone/volt",
  },
  config = function()
    require("triforce").setup({
      -- Optional: Add your configuration here
      keymap = {
        show_profile = "<leader>tp", -- Open profile with <leader>tp
      },
    })
  end,
}	},
}
