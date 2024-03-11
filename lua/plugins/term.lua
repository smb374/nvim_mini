return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = function(_, _)
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    return {
      { "<leader>gg", function() lazygit:toggle() end, desc = "LazyGit" },
      { "<C-_>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal", mode = "n" },
    }
  end,
  opts = {},
}
