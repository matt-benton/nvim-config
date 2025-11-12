return {
  { 'hrsh7th/cmp-nvim-lsp' }, -- needed by nvim-cmp and nvim-lspconfig
  { 'onsails/lspkind-nvim' }, -- needed by nvim-cmp and nvim-lspconfig


  




  -- Language server protocol
    {
      'neovim/nvim-lspconfig',
      dependencies = {
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
      },
      config = function()
	-- Setup Mason to automatically install LSP servers
	require('mason').setup()
	require('mason-lspconfig').setup({
				-- automatic_enable = {
				-- 	exclude = {
				-- 		"ts_ls"
				-- 	}
				-- }
				automatic_installation = false,
				ensure_installed = { 'vue_ls', 'intelphense', 'lua-language-server' },
	})

	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- PHP
	-- require('lspconfig').intelephense.setup({ capabilities = capabilities }) -- deprecated
vim.lsp.enable('intelephense', { capabilities = capabilities })

	-- Vue, JavaScript, TypeScript
	local util = require 'lspconfig.util' -- deprecated
-- local util = vim.lsp.config.util

	-- Find the typescript server for the project or fallback to the global ts install
	local function get_typescript_server_path(root_dir)

	local global_ts = '/opt/homebrew/lib/node_modules/typescript/lib'
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	local found_ts = ''
	local function check_dir(path)
	  found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
	  if util.path.exists(found_ts) then
	    return path
	  end
	end
	if util.search_ancestors(root_dir, check_dir) then
	  return found_ts
	else
	  return global_ts
	end
      end

      local lspconfig = require "lspconfig" -- deprecated
			-- local lspconfig = vim.lsp.config

-- lspconfig.ts_ls.setup {
--   -- on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin", -- this needs to be installed globally for this to work
-- 	      location = "/opt/homebrew/lib/@vue/language-server",
--         languages = { "vue" },
--       },
--     },
--   },
--   filetypes = { "typescript", "javascript", "vue" },
-- }

lspconfig.vue_ls.setup({
  capabilities = capabilities,
  filetypes = { "vue" },
})

vim.lsp.enable('lua_ls')

      -- Keymaps
      vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
      vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

      -- Diagnostic configuration
      vim.diagnostic.config({
	  virtual_text = false,
	  float = {
	      source = true,
	  }
      })
      end,
    },
}
