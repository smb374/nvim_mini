local augroup = require("lib").augroup

-- Disable indentscope on some buffers.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("disable_indentscope"),
  pattern = {
    "alpha",
    "coc-explorer",
    "dashboard",
    "fzf", -- fzf-lua
    "help",
    "lazy",
    "lazyterm",
    "lspsagafinder",
    "mason",
    "neo-tree",
    "nnn",
    "notify",
    "NvimTree",
    "qf",
    "toggleterm",
    "Trouble",
  },
  callback = function(_)
    vim.b.miniindentscope_disable = true
  end,
})

local indentscope = require("mini.indentscope")
indentscope.setup({
  draw = {
    delay = 50,
    animation = indentscope.gen_animation.none(),
  },
  symbol = "│",
  options = { try_as_border = true },
})
