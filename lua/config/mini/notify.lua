require("mini.notify").setup({
  lsp_progress = {
    enable = false,
  }
})

vim.notify = require("mini.notify").make_notify()
