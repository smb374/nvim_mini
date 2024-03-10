local au = function(event, pattern, callback, desc)
  vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
end

au("TextYankPost", "*", function()
  vim.highlight.on_yank()
end, "Highlight yanked text")

local start_terminal_insert = vim.schedule_wrap(function(data)
  -- Try to start terminal mode only if target terminal is current
  if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == "terminal") then
    return
  end
  vim.cmd("startinsert")
end)
au("TermOpen", "term://*", start_terminal_insert, "Start builtin terminal in Insert mode")
