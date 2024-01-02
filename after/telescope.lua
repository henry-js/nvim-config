local builtin = require("telescope.builtin")
local map = vim.keymap.set
map("n", "<leader>f", builtin.find_files, {})
