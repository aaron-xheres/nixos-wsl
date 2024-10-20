return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local finder = function()
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                return require("telescope.finders").new_table({
                    results = file_paths,
                })
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = finder(),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                    attach_mappings = function(prompt_bufnr, map)
                        map("i", "<C-d>", function()
                            local state = require("telescope.actions.state")
                            local selected_entry = state.get_selected_entry()
                            local current_picker = state.get_current_picker(prompt_bufnr)

                            table.remove(harpoon_files.items, selected_entry.index)
                            current_picker:refresh(finder())
                        end)
                        return true
                    end,
                })
                :find()
        end

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add" })

        keymap.set("n", "<leader>hc", function()
            harpoon:list():clear()
        end, { desc = "Harpoon: Clear list " })

        keymap.set("n", "<C-e>", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Harpoon: Toggle list" })
    end,
}
