-- Set leader key to comma
-- vim.g.mapleader = ',' THIS HAS BEEN MOVED TO user.lazy
-- vim.g.maplocalleader = ','

-- Open config files in new tab
vim.keymap.set('n', '<Leader>ev', ':tabedit ~/.config/nvim/lua/init.lua<CR>')
vim.keymap.set('n', '<Leader>evo', ':tabedit ~/.config/nvim/lua/user/options.lua<CR>')
vim.keymap.set('n', '<Leader>evk', ':tabedit ~/.config/nvim/lua/user/keymaps.lua<CR>')
vim.keymap.set('n', '<Leader>evp', ':tabedit ~/.config/nvim/lua/user/plugins/')
vim.keymap.set('n', '<Leader>2', ':tabedit ~/.config/nvim/snippets/php.snippets<CR>')
vim.keymap.set('n', '<Leader>3', ':tabedit ~/.config/nvim/snippets/vue.snippets<CR>')
vim.keymap.set('n', '<Leader>evl', ':tabedit ~/.config/nvim/lua/user/lazy.lua<CR>')

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain cursor position when yanking a visual selection
vim.keymap.set('v', 'y', 'myy`y')

-- Clear highlighted search text
vim.keymap.set('n', '<Leader> ', ':nohlsearch<CR>')

-- Move lines up and down
-- vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('n', '<C-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<C-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<C-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":move '<-2<CR>gv=gv")

-- Format files
vim.keymap.set('n', '<Leader>f', ':!./vendor/bin/pint --dirty<CR>')
vim.keymap.set('n', '<Leader>fjs', ':!npx prettier . --write<CR>')

-- Dump database
vim.keymap.set('n', '<Leader>ddb', function ()
  local username = vim.fn.input('Username: ', 'root')
  local db_name = vim.fn.input('Database name: ')
  vim.cmd('!mysqldump -u ' .. username .. ' -h 127.0.0.1 -P 3306 -p ' .. db_name .. ' > ~/Dumps/' .. db_name .. '.sql')
end)

-- Dump database
vim.keymap.set('n', '<Leader>dbd', function ()
  local username = vim.ui.input({
    prompt = 'Username: ',
    default = 'root'
  }, function (username)
    local db_name = vim.fn.input('Database name: ')
    vim.cmd('!mysqldump -u ' .. username .. ' -h 127.0.0.1 -P 3306 -p ' .. db_name .. ' > ~/Dumps/' .. db_name .. '.sql')
  end)
end)

-- Import database
vim.keymap.set('n', '<Leader>dbi', function ()
  local dumps_dir = vim.fn.expand('~/Dumps')

  -- get subdirectories in the dumps folder
  local subdirs = vim.fn.glob(dumps_dir .. '/*', false, true)

  -- extract directory names for display
  local dir_names = {}
  for _, path in ipairs(subdirs) do
    if vim.fn.isdirectory(path) == 1 then
      local name = vim.fn.fnamemodify(path, ':t')
      table.insert(dir_names, name)
    end
  end

  if #dir_names == 0 then
    print('No subdirectories found in dumps folder')
    return
  end

  -- select the subdirectory
  vim.ui.select(dir_names, {
    prompt = 'Select project directory:',
  }, function (project)
    if not project then return end

    local backup_dir = dumps_dir .. '/' .. project .. '/'
    local files = vim.fn.glob(backup_dir .. '*.{sql,dump}', false, true)

    -- extract just filenames for display
    local file_names = {}
    for _, file in ipairs(files) do
      local name = vim.fn.fnamemodify(file, ':t')
      table.insert(file_names, name)
    end

    if #file_names == 0 then
      print('No .sql or .dump files found in ' .. backup_dir)
      return
    end

    -- select the sql file
    vim.ui.select(file_names, {
      prompt = 'Select file to import:',
    }, function (choice)
        if choice then
          local full_path = backup_dir .. '/' .. choice
          local db_name = vim.fn.input('Database name: ')
          if db_name ~= '' then
            -- FIXME: add options for username, address, and port
            vim.cmd('terminal mysql -u root -h 127.0.0.1 -P 3306 -p ' .. db_name .. ' < ' .. full_path)
          end
        end
    end)
  end)
end)
