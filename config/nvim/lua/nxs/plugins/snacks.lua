local keybind = require("nxs.utils.keybind")

return {
  {
    -- Common snacks nvim config
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    -- picker
    "folke/snacks.nvim",
    dependencies = { { "folke/trouble.nvim" } },
    config = function()
      local Snacks = require("snacks")
      local trouble_actions = require("trouble.sources.snacks").actions

      Snacks.setup({
        picker = {
          enabled = true,
          actions = trouble_actions,
          formatters = {
            file = {
              filename_first = true,
              truncate = 100
            },
          },
          layout = {
            layout = {
              row = 1,
              width = 0.4,
              min_width = 80,
              height = 0.9,
              border = "none",
              box = "vertical",
              {
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
              {
                win = "preview",
                title = "{preview}",
                height = 0.6,
                border = "rounded",
              },
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
        },
      })

      keybind.set("", "<leader><space>", function()
        Snacks.picker.smart({
          filter = {
            paths = {
              -- Need to add cwd as filter.path because `smart` picker includes
              -- vim.v.oldfiles which may contain files outside the cwd
              [vim.fn.getcwd()] = true,
              [vim.fn.getcwd() .. "/.git"] = false
            },
          }
        })
      end, "Smart Find Files")
      keybind.set("", "<leader>,", function()
        Snacks.picker.buffers()
      end, "Buffers")
      keybind.set("", "<leader>/", function()
        Snacks.picker.grep()
      end, "Grep")
      keybind.set("", "<leader>:", function()
        Snacks.picker.command_history()
      end, "Command History")
      keybind.set("", "<leader>n", function()
        Snacks.picker.notifications()
      end, "Notification History")
      -- find
      keybind.set("", "<leader>fb", function()
        Snacks.picker.buffers()
      end, "Buffers")
      keybind.set("", "<leader>fc", function()
        ---@diagnostic disable-next-line: assign-type-mismatch
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end, "Find Config File")
      keybind.set("", "<leader>ff", function()
        Snacks.picker.files()
      end, "Find Files")
      keybind.set("", "<leader>fg", function()
        Snacks.picker.git_files()
      end, "Find Git Files")
      keybind.set("", "<leader>fp", function()
        Snacks.picker.projects()
      end, "Projects")
      keybind.set("", "<leader>fr", function()
        Snacks.picker.recent()
      end, "Recent")
      -- git
      keybind.set("", "<leader>gb", function()
        Snacks.picker.git_branches()
      end, "Git Branches")
      keybind.set("", "<leader>gl", function()
        Snacks.picker.git_log()
      end, "Git Log")
      keybind.set("", "<leader>gL", function()
        Snacks.picker.git_log_line()
      end, "Git Log Line")
      keybind.set("", "<leader>gs", function()
        Snacks.picker.git_status()
      end, "Git Status")
      keybind.set("", "<leader>gS", function()
        Snacks.picker.git_stash()
      end, "Git Stash")
      keybind.set("", "<leader>gd", function()
        Snacks.picker.git_diff()
      end, "Git Diff (Hunks)")
      keybind.set("", "<leader>gf", function()
        Snacks.picker.git_log_file()
      end, "Git Log File")
      -- Grep
      keybind.set("", "<leader>sb", function()
        Snacks.picker.lines()
      end, "Buffer Lines")
      keybind.set("", "<leader>sB", function()
        Snacks.picker.grep_buffers()
      end, "Grep Open Buffers")
      keybind.set("", "<leader>sg", function()
        Snacks.picker.grep()
      end, "Grep")
      keybind.set({ "n", "x" }, "<leader>sw", function()
        Snacks.picker.grep_word()
      end, "Visual selection or word")
      -- search
      keybind.set("", '<leader>s"', function()
        Snacks.picker.registers()
      end, "Registers")
      keybind.set("", "<leader>s/", function()
        Snacks.picker.search_history()
      end, "Search History")
      keybind.set("", "<leader>sa", function()
        Snacks.picker.autocmds()
      end, "Autocmds")
      keybind.set("", "<leader>sb", function()
        Snacks.picker.lines()
      end, "Buffer Lines")
      keybind.set("", "<leader>sc", function()
        Snacks.picker.command_history()
      end, "Command History")
      keybind.set("", "<leader>sC", function()
        Snacks.picker.commands()
      end, "Commands")
      keybind.set("", "<leader>sd", function()
        Snacks.picker.diagnostics()
      end, "Diagnostics")
      keybind.set("", "<leader>sD", function()
        Snacks.picker.diagnostics_buffer()
      end, "Buffer Diagnostics")
      keybind.set("", "<leader>sh", function()
        Snacks.picker.help()
      end, "Help Pages")
      keybind.set("", "<leader>sH", function()
        Snacks.picker.highlights()
      end, "Highlights")
      keybind.set("", "<leader>si", function()
        Snacks.picker.icons()
      end, "Icons")
      keybind.set("", "<leader>sj", function()
        Snacks.picker.jumps()
      end, "Jumps")
      keybind.set("", "<leader>sk", function()
        Snacks.picker.keymaps()
      end, "Keymaps")
      keybind.set("", "<leader>sl", function()
        Snacks.picker.loclist()
      end, "Location List")
      keybind.set("", "<leader>sm", function()
        Snacks.picker.marks()
      end, "Marks")
      keybind.set("", "<leader>sM", function()
        Snacks.picker.man()
      end, "Man Pages")
      keybind.set("", "<leader>sp", function()
        Snacks.picker.lazy()
      end, "Search for Plugin Spec")
      keybind.set("", "<leader>sq", function()
        Snacks.picker.qflist()
      end, "Quickfix List")
      keybind.set("", "<leader>sR", function()
        Snacks.picker.resume()
      end, "Resume")
      keybind.set("", "<leader>su", function()
        Snacks.picker.undo()
      end, "Undo History")
      keybind.set("", "<leader>uC", function()
        Snacks.picker.colorschemes()
      end, "Colorschemes")
    end,
  },
}
