local current_popup_line = nil
local popup_win = nil

vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        local line = vim.fn.line(".")

        if line == 69 and current_popup_line ~= line then
            current_popup_line = line

            local buf = vim.api.nvim_create_buf(false, true)

            vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "nice!" })

            vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

            popup_win = vim.api.nvim_open_win(buf, false, {
                relative = "cursor",
                row = 1,
                col = 0,
                width = 5,
                height = 1,
                style = "minimal",
            })
        elseif line ~= 69 and current_popup_line == 69 then
            current_popup_line = nil

            if popup_win and vim.api.nvim_win_is_valid(popup_win) then
                vim.api.nvim_win_close(popup_win, true)
            end
        end
    end,
})
