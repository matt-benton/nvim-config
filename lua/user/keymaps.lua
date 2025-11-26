-- Set leader key to comma
-- vim.g.mapleader = ',' THIS HAS BEEN MOVED TO user.lazy
-- vim.g.maplocalleader = ','

-- Open config files in new tab
vim.keymap.set("n", "<Leader>ev", ":tabedit ~/.config/nvim/lua/init.lua<CR>")
vim.keymap.set("n", "<Leader>evo", ":tabedit ~/.config/nvim/lua/user/options.lua<CR>")
vim.keymap.set("n", "<Leader>evk", ":tabedit ~/.config/nvim/lua/user/keymaps.lua<CR>")
vim.keymap.set("n", "<Leader>evp", ":tabedit ~/.config/nvim/lua/user/plugins/")
vim.keymap.set("n", "<Leader>2", ":tabedit ~/.config/nvim/snippets/php.snippets<CR>")
vim.keymap.set("n", "<Leader>3", ":tabedit ~/.config/nvim/snippets/vue.snippets<CR>")
vim.keymap.set("n", "<Leader>evl", ":tabedit ~/.config/nvim/lua/user/lazy.lua<CR>")

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain cursor position when yanking a visual selection
vim.keymap.set("v", "y", "myy`y")

-- Clear highlighted search text
vim.keymap.set("n", "<Leader> ", ":nohlsearch<CR>")

-- Move lines up and down
-- vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set("n", "<C-j>", ":move .+1<CR>==")
vim.keymap.set("n", "<C-k>", ":move .-2<CR>==")
vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv=gv")

-- Format files
vim.keymap.set("n", "<Leader>f", ":!./vendor/bin/pint --dirty<CR>")
vim.keymap.set("n", "<Leader>fjs", ":!npx prettier . --write<CR>")

-- Dump database
vim.keymap.set("n", "<Leader>dbd", function()
    local dumps_dir = vim.fn.expand("~/Dumps")

    -- get subdirectories in the dumps folder
    local subdirs = vim.fn.glob(dumps_dir .. "/*", false, true)

    -- extract directory names for display
    local dir_names = {}
    for _, path in ipairs(subdirs) do
        if vim.fn.isdirectory(path) == 1 then
            local name = vim.fn.fnamemodify(path, ":t")
            table.insert(dir_names, name)
        end
    end

    if #dir_names == 0 then
        print("No subdirectories found in dumps folder")
        return
    end

    -- select the subdirectory
    vim.ui.select(dir_names, {
        prompt = "Select project directory:",
    }, function(project)
        if not project then
            return
        end

        local backup_dir = dumps_dir .. "/" .. project .. "/"

        vim.ui.input({
            prompt = "Username: ",
            default = "root",
        }, function(username)
            vim.ui.input({
                prompt = "Database name: ",
            }, function(db_name)
                local date = os.date("%Y-%m-%d")
                vim.ui.input({
                    prompt = "Dump filename: ",
                    default = db_name .. "_" .. date,
                }, function(filename)
                    vim.cmd(
                        "!mysqldump -u "
                            .. username
                            .. " -h 127.0.0.1 -P 3306 -p "
                            .. db_name
                            .. " > "
                            .. backup_dir
                            .. filename
                            .. ".sql"
                    )
                end)
            end)
        end)
    end)
end)

-- Import database
vim.keymap.set("n", "<Leader>dbi", function()
    local dumps_dir = vim.fn.expand("~/Dumps")

    -- get subdirectories in the dumps folder
    local subdirs = vim.fn.glob(dumps_dir .. "/*", false, true)

    -- extract directory names for display
    local dir_names = {}
    for _, path in ipairs(subdirs) do
        if vim.fn.isdirectory(path) == 1 then
            local name = vim.fn.fnamemodify(path, ":t")
            table.insert(dir_names, name)
        end
    end

    if #dir_names == 0 then
        print("No subdirectories found in dumps folder")
        return
    end

    -- select the subdirectory
    vim.ui.select(dir_names, {
        prompt = "Select project directory:",
    }, function(project)
        if not project then
            return
        end

        local backup_dir = dumps_dir .. "/" .. project .. "/"
        local files = vim.fn.glob(backup_dir .. "*.{sql,dump}", false, true)

        -- extract just filenames for display
        local file_names = {}
        for _, file in ipairs(files) do
            local name = vim.fn.fnamemodify(file, ":t")
            table.insert(file_names, name)
        end

        if #file_names == 0 then
            print("No .sql or .dump files found in " .. backup_dir)
            return
        end

        -- select the sql file
        vim.ui.select(file_names, {
            prompt = "Select file to import:",
        }, function(choice)
            if choice then
                local full_path = backup_dir .. "/" .. choice
                local db_database = vim.fn.input("Database name: ")
                local db_username = vim.fn.input("Database username: ", "root")
                local host = vim.fn.input("MySQL host: ", "127.0.0.1")
                local port = vim.fn.input("MySQL port: ", "3306")

                if db_database ~= "" then
                    vim.cmd(
                        "terminal mysql -u "
                            .. db_username
                            .. " -h "
                            .. host
                            .. " -P "
                            .. port
                            .. " -p "
                            .. db_database
                            .. " < "
                            .. full_path
                    )
                end
            end
        end)
    end)
end)

-- open up laravel dusk screenshot
vim.keymap.set("n", "<Leader>dss", function()
    local project_dir = vim.fn.getcwd()
    print(project_dir .. " project directory")

    -- check to see if project_dir has a tests/Browser/screenshots
    local screenshots_dir = project_dir .. "/tests/Browser/screenshots"
    if vim.fn.isdirectory(screenshots_dir) == 0 then
        print("Screenshots not found")
        return
    end

    -- get file names from screenshots_dir and
    -- put them into a table
    local files = vim.fn.glob(screenshots_dir .. "/*", false, true)

    local file_names = {}
    for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t")
        table.insert(file_names, name)
    end

    if #file_names == 0 then
        print("No screenshot files found in " .. screenshots_dir)
    elseif #file_names == 1 then
        os.execute("open " .. screenshots_dir .. "/" .. file_names[1])
    else
        vim.ui.select(file_names, {
            prompt = "Select screenshot:",
        }, function(choice)
            if choice then
                vim.ui.open(screenshots_dir .. "/" .. choice)
            end
        end)
    end
end)
