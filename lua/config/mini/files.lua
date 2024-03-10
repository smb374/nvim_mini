require("mini.files").setup()

local map = vim.keymap.set
map("n", "<leader>e", function()
  require("mini.files").open()
end, { desc = "Open File Explorer" })
