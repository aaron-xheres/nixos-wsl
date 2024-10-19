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
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
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

    keymap.set("n", "<C-n>", function()
      harpoon:list():next()
    end, { desc = "Harpoon: Goto next" })

    keymap.set("n", "<C-p>", function()
      harpoon:list():prev()
    end, { desc = "Harpoon: Goto prev" })
  end,
}
