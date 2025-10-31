require('telescope').setup({
    defaults = {
    file_ignore_patterns = {
      '.git/',
      '.node_modules',
      '.vendor',
      'public/build',
    },
      preview = {
        hide_on_startup = true,
      },
    },
})



require('telescope').load_extension('fzf')

vim.keymap.set('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<C-h>', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<C-g>', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
