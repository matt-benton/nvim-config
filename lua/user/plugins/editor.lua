return {
	-- { 'tpope/vim-sleuth' }, -- indent autodetect with editorconfig support (2025-04-14 disabling this for now because it is conflicting with polyglot)
	{ 'farmergreg/vim-lastplace' }, -- remember last place when opening a file
	{
	  'karb94/neoscroll.nvim', -- smooth scrolling when jumping around
	  config = function()
		require('neoscroll').setup()
	  end,
	},
	{
	  'nvim-tree/nvim-tree.lua',
	  config = function()
		require('nvim-tree').setup()
			vim.keymap.set('n', '<Leader>fi', ':NvimTreeToggle<CR>')
	  end,
	},
	{
		'nvim-lualine/lualine.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			require('lualine').setup({
				options = {
				  globalstatus = true,
				},
				sections = {
				  lualine_a = { 'mode' },
				  lualine_b = {
					'branch',
					'diff',
					{ 'diagnostics', sources = { 'nvim_diagnostic' } },
				  },
				  lualine_c = { 'filename', 'searchcount' },
				  lualine_x = { 'filetype' },
				  lualine_y = { 'progress' },
				  lualine_z = { 'location' },
				},
			})
			end,
	},
	{
		'voldikss/vim-floaterm',
		config = function()
		  vim.g.floaterm_width = 0.8
		  vim.g.floaterm_height = 0.8
		  vim.g.floaterm_title = ""
		  vim.g.floaterm_borderchars = ""
		  vim.keymap.set('n', '<Leader>ft', ':FloatermToggle<CR>')
		  vim.cmd([[
			highlight link FloatermBorder CursorLine
			highlight link Floaterm CursorLine
		  ]])
		end
	},
	{
	  'projekt0n/github-nvim-theme',
		  name = 'github-theme',
		  lazy = false, -- make sure we load this during startup if it is your main colorscheme
		  priority = 1000, -- make sure to load this before all the other start plugins
		  config = function()
			require('github-theme').setup({
			  -- ...
			})

		vim.cmd('colorscheme github_dark_default')
	  end,
	},
	{
	  "chentoast/marks.nvim",
	  event = "VeryLazy",
	  opts = {},
	},
	-- {
	--   'nvimdev/dashboard-nvim', -- adds dashboard on startup
	--   event = 'VimEnter',
	--   config = function()
	-- 		require('dashboard').setup {
	-- 		  -- config
	-- 		  theme = 'hyper',
	-- 		  config = {
            -- week_header = {
              -- enable = true,
            -- },
	-- 		  },
	-- 		}
	--   end,
	--   dependencies = {'nvim-tree/nvim-web-devicons'}
	-- }
}
