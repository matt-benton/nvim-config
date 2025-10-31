return {
  {
      'lewis6991/gitsigns.nvim',
      config = function()
	      require('gitsigns').setup()
	      vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
	      vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
	      vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
	      vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
      end,
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<Leader>do', ':DiffviewOpen<CR>')
      vim.keymap.set('n', '<Leader>dc', ':DiffviewClose<CR>')
    end,
  },
}
