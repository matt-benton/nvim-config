return {
  {
      'nvim-treesitter/nvim-treesitter', -- Improved syntax highlighting
			build = ":TSUpdate",
      requires = {
	      'nvim-treesitter/nvim-treesitter-textobjects',
      },
      config = function()
	      -- require('user.plugins.treesitter')
	      require('nvim-treesitter.configs').setup({
				ensure_installed = {
					"css",
					"diff",
					"editorconfig",
					"gitignore",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"php",
					"phpdoc",
					"scss",
					"sql",
					"typescript",
					"vue",
					"xml",
					"yaml",
				},
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
					      ['if'] = '@function.inner',
					      ['af'] = '@function.outer',
					      ['ia'] = '@parameter.inner',
					      ['aa'] = '@parameter.outer',
					      ['il'] = '@loop.inner',
					      ['al'] = '@loop.outer',
				      },
				    },
			    },
	      })
      end,
  }
}
