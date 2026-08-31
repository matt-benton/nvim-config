return {
    {
        "sudo-tee/opencode.nvim",
        dependencies = {
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    anti_conceal = { enabled = false },
                    file_types = { "markdown", "opencode_output" },
                },
                ft = { "markdown", "opencode_output" },
            },
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            preferred_completion = "nvim-cmp",
            preferred_picker = "telescope",
        },
    },
}
