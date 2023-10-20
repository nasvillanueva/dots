return {
  is_git_project = function()
    local _, ret, _ = require("telescope.utils").get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })

    return ret == 0
  end
}
