return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = function(_, _)
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    return {
      { "<leader>gg", function() lazygit:toggle() end,            desc = "LazyGit" },
      { "<C-/>",      "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Terminal (Float)",      mode = "n" },
      { "<C-_>",      "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Terminal (Float)",      mode = "n" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Terminal (Horizontal)", mode = "n" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Terminal (Vertical)",   mode = "n" },
    }
  end,
  opts = {},
  config = function(_, opts)
    require("toggleterm").setup(opts)
    vim.api.nvim_create_autocmd("TermOpen", {
      group = vim.api.nvim_create_augroup("set_term_keymap", { clear = true }),
      pattern = "term://*",
      callback = function()
        local opts = { buffer = 0 }
        local set_map = function(key, action)
          vim.keymap.set("t", key, action, opts)
        end
        local maps = {
          { '<esc>', "<C-\\><C-n>", },
          { 'jk',    "<C-\\><C-n>", },
          { '<C-h>', "<cmd>wincmd h<cr>", },
          { '<C-j>', "<cmd>wincmd j<cr>", },
          { '<C-k>', "<cmd>wincmd k<cr>", },
          { '<C-l>', "<cmd>wincmd l<cr>", },
          { '<C-w>', "<C-\\><C-n><C-w>", },
        }
        for _, ks in ipairs(maps) do
          local key = ks[1]
          local act = ks[2]
          set_map(key, act)
        end
      end
    })
  end
}
