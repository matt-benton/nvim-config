require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            "branch",
            "diff",
            { "diagnostics", sources = { "nvim_diagnostic" } },
        },
        lualine_c = { "filename", "searchcount" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})
