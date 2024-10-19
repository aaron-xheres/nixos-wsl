-- Consts
vim.g.mapleader = " "
local keymap = vim.keymap

-- ###

-- Search
keymap.set("n", "<leader>nh", ":nohl<cr>", { desc = "Search: Clear highlights" })

-- Window Management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split: Vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split: Horizontally" })
keymap.set("n", "<leader>sc", "<cmd>close<cr>", { desc = "Split: Close" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Split: Focus Up" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Split: Focus Down" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Split: Focus Left" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Split: Focus Right" })

keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Tab: Open" })
keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Tab: Close" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<cr>", { desc = "Tab: New current buffer" })
keymap.set("n", "<C-]>", "<cmd>tabn<cr>", { desc = "Tab: Next" })
keymap.set("n", "<C-[>", "<cmd>tabp<cr>", { desc = "Tab: Previous" })

-- Terminal Management
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: Escape" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: Focus Up" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: Focus Down" })
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: Focus Left" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: Focus Right" })
