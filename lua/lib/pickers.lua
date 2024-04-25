local M = {}

function M.pick_files_dir(dir)
  local pick = require("mini.pick")
  pick.builtin.files({}, {
    source = {
      cwd = dir,
    },
  })
end

function M.pick_project()
  local history = require("project_nvim.utils.history")
  local pick = require("mini.pick")
  local function choose_action(item)
    if not vim.fn.isdirectory(item) then
      return
    end
    M.pick_files_dir(item)
  end
  pick.start({
    source = {
      items = history.get_recent_projects(),
      choose = choose_action,
      name = "Projects"
    }
  })
end

return M
