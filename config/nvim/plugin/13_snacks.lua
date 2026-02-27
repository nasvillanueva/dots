local setup_lazygit = function()
  _G.nxs.keybind_set("n", "<leader>gg", function()
    require("snacks").lazygit.open()
  end, "LazyGit")
  _G.nxs.keybind_set("n", "<leader>gf", function()
    require("snacks").lazygit.log_file()
  end, "LazyGit: Current File Commit History")
  _G.nxs.keybind_set("n", "<leader>gl", function()
    require("snacks").lazygit.log()
  end, "LazyGit: Git Log")
end

local setup_picker = function()
  _G.nxs.keybind_set("", "<leader><space>", function()
    Snacks.picker.smart({
      filter = {
        paths = {
          -- Need to add cwd as filter.path because `smart` picker includes
          -- vim.v.oldfiles which may contain files outside the cwd
          [vim.fn.getcwd()] = true,
          [vim.fn.getcwd() .. "/.git"] = false,
        },
      },
    })
  end, "Picker: Smart Find Files", { remap = true })
  _G.nxs.keybind_set("", "<leader>,", function()
    Snacks.picker.buffers()
  end, "Picker: Buffers", { remap = true })
  _G.nxs.keybind_set("", "<leader>/", function()
    Snacks.picker.grep()
  end, "Picker: Grep", { remap = true })
  _G.nxs.keybind_set("", "<leader>.", function()
    local path = vim.fn.expand("%:p:h")
    if vim.bo.filetype == "oil" then
      path = string.sub(path, 5)
    end
    Snacks.picker.grep({ cwd = path })
  end, "Picker: Grep CWD", { remap = true })

  _G.nxs.keybind_set("", "<leader>:", function()
    Snacks.picker.command_history()
  end, "Picker: Command History", { remap = true })
  _G.nxs.keybind_set("", "<leader>n", function()
    Snacks.picker.notifications()
  end, "Picker: Notification History", { remap = true })
  -- find
  _G.nxs.keybind_set("", "<leader>fb", function()
    Snacks.picker.buffers()
  end, "Picker: Buffers", { remap = true })
  _G.nxs.keybind_set("", "<leader>fc", function()
    ---@diagnostic disable-next-line: assign-type-mismatch
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
  end, "Picker: Find Config File", { remap = true })
  _G.nxs.keybind_set("", "<leader>ff", function()
    Snacks.picker.files()
  end, "Picker: Find Files", { remap = true })
  _G.nxs.keybind_set("", "<leader>fg", function()
    Snacks.picker.git_files()
  end, "Picker: Find Git Files", { remap = true })
  _G.nxs.keybind_set("", "<leader>fp", function()
    Snacks.picker.projects()
  end, "Picker: Projects", { remap = true })
  _G.nxs.keybind_set("", "<leader>fr", function()
    Snacks.picker.recent({
      filter = {
        paths = {
          -- Need to add cwd as filter.path because `smart` picker includes
          -- vim.v.oldfiles which may contain files outside the cwd
          [vim.fn.getcwd()] = true,
          [vim.fn.getcwd() .. "/.git"] = false,
        },
      },
    })
  end, "Picker: Recent", { remap = true })
  -- git
  _G.nxs.keybind_set("", "<leader>gb", function()
    Snacks.picker.git_branches()
  end, "Picker: Git Branches", { remap = true })
  _G.nxs.keybind_set("", "<leader>gl", function()
    Snacks.picker.git_log()
  end, "Picker: Git Log", { remap = true })
  _G.nxs.keybind_set("", "<leader>gL", function()
    Snacks.picker.git_log_line()
  end, "Picker: Git Log Line", { remap = true })
  _G.nxs.keybind_set("", "<leader>gs", function()
    Snacks.picker.git_status()
  end, "Picker: Git Status", { remap = true })
  _G.nxs.keybind_set("", "<leader>gS", function()
    Snacks.picker.git_stash()
  end, "Picker: Git Stash", { remap = true })
  _G.nxs.keybind_set("", "<leader>gf", function()
    Snacks.picker.git_log_file()
  end, "Picker: Git Log File", { remap = true })
  -- Grep
  _G.nxs.keybind_set("", "<leader>sb", function()
    Snacks.picker.lines()
  end, "Picker: Buffer Lines", { remap = true })
  _G.nxs.keybind_set("", "<leader>sB", function()
    Snacks.picker.grep_buffers()
  end, "Picker: Grep Open Buffers", { remap = true })
  _G.nxs.keybind_set("", "<leader>sg", function()
    Snacks.picker.grep()
  end, "Picker: Grep", { remap = true })
  _G.nxs.keybind_set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
  end, "Picker: Visual selection or word", { remap = true })
  -- search
  _G.nxs.keybind_set("", '<leader>s"', function()
    Snacks.picker.registers()
  end, "Picker: Registers", { remap = true })
  _G.nxs.keybind_set("", "<leader>s/", function()
    Snacks.picker.search_history()
  end, "Picker: Search History", { remap = true })
  _G.nxs.keybind_set("", "<leader>sa", function()
    Snacks.picker.autocmds()
  end, "Picker: Autocmds", { remap = true })
  _G.nxs.keybind_set("", "<leader>sb", function()
    Snacks.picker.lines()
  end, "Picker: Buffer Lines", { remap = true })
  _G.nxs.keybind_set("", "<leader>sc", function()
    Snacks.picker.command_history()
  end, "Picker: Command History", { remap = true })
  _G.nxs.keybind_set("", "<leader>sC", function()
    Snacks.picker.commands()
  end, "Picker: Commands", { remap = true })
  _G.nxs.keybind_set("", "<leader>sd", function()
    Snacks.picker.diagnostics()
  end, "Picker: Diagnostics", { remap = true })
  _G.nxs.keybind_set("", "<leader>sD", function()
    Snacks.picker.diagnostics_buffer()
  end, "Picker: Buffer Diagnostics", { remap = true })
  _G.nxs.keybind_set("", "<leader>sh", function()
    Snacks.picker.help()
  end, "Picker: Help Pages", { remap = true })
  _G.nxs.keybind_set("", "<leader>sH", function()
    Snacks.picker.highlights()
  end, "Picker: Highlights", { remap = true })
  _G.nxs.keybind_set("", "<leader>si", function()
    Snacks.picker.icons()
  end, "Picker: Icons", { remap = true })
  _G.nxs.keybind_set("", "<leader>sj", function()
    Snacks.picker.jumps()
  end, "Picker: Jumps", { remap = true })
  _G.nxs.keybind_set("", "<leader>sk", function()
    Snacks.picker.keymaps()
  end, "Picker: Keymaps", { remap = true })
  _G.nxs.keybind_set("", "<leader>sl", function()
    Snacks.picker.loclist()
  end, "Picker: Location List", { remap = true })
  _G.nxs.keybind_set("", "<leader>sm", function()
    Snacks.picker.marks()
  end, "Picker: Marks", { remap = true })
  _G.nxs.keybind_set("", "<leader>sM", function()
    Snacks.picker.man()
  end, "Picker: Man Pages", { remap = true })
  _G.nxs.keybind_set("", "<leader>sp", function()
    Snacks.picker.lazy()
  end, "Picker: Search for Plugin Spec", { remap = true })
  _G.nxs.keybind_set("", "<leader>sq", function()
    Snacks.picker.qflist()
  end, "Picker: Quickfix List", { remap = true })
  _G.nxs.keybind_set("", "<leader>sR", function()
    Snacks.picker.resume()
  end, "Picker: Resume", { remap = true })
  _G.nxs.keybind_set("", "<leader>su", function()
    Snacks.picker.undo()
  end, "Picker: Undo History", { remap = true })
  _G.nxs.keybind_set("", "<leader>uC", function()
    Snacks.picker.colorschemes()
  end, "Picker: Colorschemes", { remap = true })

  _G.nxs.keybind_set("n", "<leader>st", function()
    require("snacks").picker.todo_comments()
  end, "Picker: Todo")
  _G.nxs.keybind_set("n", "<leader>sT", function()
    require("snacks").picker.todo_comments({
      keywords = { "TODO", "FIX", "FIXME" },
    })
  end, "Picker: Todo/Fix/Fixme")
end

MiniDeps.now(function()
  MiniDeps.add({
    source = "folke/snacks.nvim",
    depends = { "folke/trouble.nvim" },
  })

  require("snacks").setup({
    indent = {
      animate = {
        enabled = false,
      },
    },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = {
      enabled = true,
      -- on_show = function()
      --   vim.cmd.startinsert()
      -- end,
      actions = require("trouble.sources.snacks").actions,
      main = {
        file = false, -- allow non file windows open the selected file
      },
      formatters = {
        file = {
          filename_first = true,
          truncate = 100,
        },
      },
      win = {
        input = {
          keys = {
            ["<C-t>"] = { "trouble_open", mode = { "n", "i" } },
            -- Disable conflicting keybinds for bsuth/emacs-binding.nvim by keeping them for
            -- input mode or disabling.
            ["<C-a>"] = { "select_all", mode = "n" },
            ["<C-b>"] = { "preview_scroll_up", mode = "n" },
            ["<C-f>"] = { "preview_scroll_down", mode = "n" },
            ["<C-d>"] = { "list_scroll_down", mode = "n" },
            ["<C-u>"] = { "list_scroll_up", mode = "n" },
            ["<A-d>"] = { "inspect", mode = "n" },
            ["<C-k>"] = false,
            ["<C-n>"] = false,
            ["<A-f>"] = false,
          },
        },
      },
      sources = {
        files = {
          hidden = true,
        },
      },
    },
  })

  setup_lazygit()
  setup_picker()
end)
