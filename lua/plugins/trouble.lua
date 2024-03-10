local minideps = require("mini.deps")
local add, later = minideps.add, minideps.later

later(function()
  add({
    source = "folke/trouble.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })
  require("trouble").setup({
    use_diagnostic_signs = true,
  })
  local map = vim.keymap.set
  map("n", "<leader>xx", function()
    require("trouble").toggle()
  end, { desc = "Trouble Toggle" })
  map("n", "<leader>xw", function()
    require("trouble").toggle("workspace_diagnostics")
  end, { desc = "Trouble Toggle (Workspace Diagnostic)" })
  map("n", "<leader>xd", function()
    require("trouble").toggle("document_diagnostics")
  end, { desc = "Trouble Toggle (Document Diagnostic)" })
  map("n", "<leader>xq", function()
    require("trouble").toggle("quickfix")
  end, { desc = "Trouble Toggle (Quickfix)" })
  map("n", "<leader>xl", function()
    require("trouble").toggle("loclist")
  end, { desc = "Trouble Toggle (Location)" })
end)
