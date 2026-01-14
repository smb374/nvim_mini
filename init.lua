if vim.g.neovide then
  vim.o.guifont = "Maple Mono NF CN:h12"
  vim.g.neovide_cursor_animation_length = 0
end

if not vim.g.vscode then
  vim.cmd("filetype plugin indent on")
  require("config")
else
  require("config.options")
end
