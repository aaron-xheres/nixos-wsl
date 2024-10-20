return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        -- Recommended settings
        vim.g.loaded_netrew = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            view = {
                width = 35,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = true, -- Use H to toggle
            },
        })

        -- Set Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer: Toggle" })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Explorer: Find" })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<cr>", { desc = "Explorer: Collapse" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Explorer: Refresh" })
    end,
}
