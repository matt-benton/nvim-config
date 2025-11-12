vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.number = true

vim.opt.completeopt = "menuone,longest,preview"

vim.opt.title = true

vim.opt.termguicolors = true

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if search contains an uppercase letter, search becomes case sensitive

vim.opt.list = true -- enable the below listchars
vim.opt.listchars = { trail = "•" }

vim.opt.fillchars:append({ eob = " " }) -- remove the ~ from end of buffer

vim.opt.splitright = true

-- keep cursor 8 lines from top or bottom of screen
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.clipboard = "unnamedplus" -- use system clipboard

vim.opt.confirm = true -- ask for confirmation instead of erroring

vim.opt.undofile = true -- remember undo history after closing vim

vim.opt.signcolumn = "yes:2"
