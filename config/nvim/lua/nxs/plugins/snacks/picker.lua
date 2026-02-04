local keybind = require("nxs.utils.keybind")

return {
  "folke/snacks.nvim",
  dependencies = { { "folke/trouble.nvim" } },
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      picker = {
        enabled = true,
        on_show = function()
          vim.cmd.startinsert()
        end,
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
  end,
  keys = {
    keybind.lazyKey("", "<leader><space>", function()
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
    end, "Picker: Smart Find Files", { remap = true }),
    keybind.lazyKey("", "<leader>,", function()
      Snacks.picker.buffers()
    end, "Picker: Buffers", { remap = true }),
    keybind.lazyKey("", "<leader>/", function()
      Snacks.picker.grep()
    end, "Picker: Grep", { remap = true }),
    keybind.lazyKey("", "<leader>.", function()
      local path = vim.fn.expand("%:p:h")
      if vim.bo.filetype == "oil" then
        path = string.sub(path, 5)
      end
      Snacks.picker.grep({ cwd = path })
    end, "Picker: Grep CWD", { remap = true }),

    keybind.lazyKey("", "<leader>:", function()
      Snacks.picker.command_history()
    end, "Picker: Command History", { remap = true }),
    keybind.lazyKey("", "<leader>n", function()
      Snacks.picker.notifications()
    end, "Picker: Notification History", { remap = true }),
    -- find
    keybind.lazyKey("", "<leader>fb", function()
      Snacks.picker.buffers()
    end, "Picker: Buffers", { remap = true }),
    keybind.lazyKey("", "<leader>fc", function()
      ---@diagnostic disable-next-line: assign-type-mismatch
      Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end, "Picker: Find Config File", { remap = true }),
    keybind.lazyKey("", "<leader>ff", function()
      Snacks.picker.files()
    end, "Picker: Find Files", { remap = true }),
    keybind.lazyKey("", "<leader>fg", function()
      Snacks.picker.git_files()
    end, "Picker: Find Git Files", { remap = true }),
    keybind.lazyKey("", "<leader>fp", function()
      Snacks.picker.projects()
    end, "Picker: Projects", { remap = true }),
    keybind.lazyKey("", "<leader>fr", function()
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
    end, "Picker: Recent", { remap = true }),
    -- git
    keybind.lazyKey("", "<leader>gb", function()
      Snacks.picker.git_branches()
    end, "Picker: Git Branches", { remap = true }),
    keybind.lazyKey("", "<leader>gl", function()
      Snacks.picker.git_log()
    end, "Picker: Git Log", { remap = true }),
    keybind.lazyKey("", "<leader>gL", function()
      Snacks.picker.git_log_line()
    end, "Picker: Git Log Line", { remap = true }),
    keybind.lazyKey("", "<leader>gs", function()
      Snacks.picker.git_status()
    end, "Picker: Git Status", { remap = true }),
    keybind.lazyKey("", "<leader>gS", function()
      Snacks.picker.git_stash()
    end, "Picker: Git Stash", { remap = true }),
    keybind.lazyKey("", "<leader>gf", function()
      Snacks.picker.git_log_file()
    end, "Picker: Git Log File", { remap = true }),
    -- Grep
    keybind.lazyKey("", "<leader>sb", function()
      Snacks.picker.lines()
    end, "Picker: Buffer Lines", { remap = true }),
    keybind.lazyKey("", "<leader>sB", function()
      Snacks.picker.grep_buffers()
    end, "Picker: Grep Open Buffers", { remap = true }),
    keybind.lazyKey("", "<leader>sg", function()
      Snacks.picker.grep()
    end, "Picker: Grep", { remap = true }),
    keybind.lazyKey({ "n", "x" }, "<leader>sw", function()
      Snacks.picker.grep_word()
    end, "Picker: Visual selection or word", { remap = true }),
    -- search
    keybind.lazyKey("", '<leader>s"', function()
      Snacks.picker.registers()
    end, "Picker: Registers", { remap = true }),
    keybind.lazyKey("", "<leader>s/", function()
      Snacks.picker.search_history()
    end, "Picker: Search History", { remap = true }),
    keybind.lazyKey("", "<leader>sa", function()
      Snacks.picker.autocmds()
    end, "Picker: Autocmds", { remap = true }),
    keybind.lazyKey("", "<leader>sb", function()
      Snacks.picker.lines()
    end, "Picker: Buffer Lines", { remap = true }),
    keybind.lazyKey("", "<leader>sc", function()
      Snacks.picker.command_history()
    end, "Picker: Command History", { remap = true }),
    keybind.lazyKey("", "<leader>sC", function()
      Snacks.picker.commands()
    end, "Picker: Commands", { remap = true }),
    keybind.lazyKey("", "<leader>sd", function()
      Snacks.picker.diagnostics()
    end, "Picker: Diagnostics", { remap = true }),
    keybind.lazyKey("", "<leader>sD", function()
      Snacks.picker.diagnostics_buffer()
    end, "Picker: Buffer Diagnostics", { remap = true }),
    keybind.lazyKey("", "<leader>sh", function()
      Snacks.picker.help()
    end, "Picker: Help Pages", { remap = true }),
    keybind.lazyKey("", "<leader>sH", function()
      Snacks.picker.highlights()
    end, "Picker: Highlights", { remap = true }),
    keybind.lazyKey("", "<leader>si", function()
      Snacks.picker.icons()
    end, "Picker: Icons", { remap = true }),
    keybind.lazyKey("", "<leader>sj", function()
      Snacks.picker.jumps()
    end, "Picker: Jumps", { remap = true }),
    keybind.lazyKey("", "<leader>sk", function()
      Snacks.picker.keymaps()
    end, "Picker: Keymaps", { remap = true }),
    keybind.lazyKey("", "<leader>sl", function()
      Snacks.picker.loclist()
    end, "Picker: Location List", { remap = true }),
    keybind.lazyKey("", "<leader>sm", function()
      Snacks.picker.marks()
    end, "Picker: Marks", { remap = true }),
    keybind.lazyKey("", "<leader>sM", function()
      Snacks.picker.man()
    end, "Picker: Man Pages", { remap = true }),
    keybind.lazyKey("", "<leader>sp", function()
      Snacks.picker.lazy()
    end, "Picker: Search for Plugin Spec", { remap = true }),
    keybind.lazyKey("", "<leader>sq", function()
      Snacks.picker.qflist()
    end, "Picker: Quickfix List", { remap = true }),
    keybind.lazyKey("", "<leader>sR", function()
      Snacks.picker.resume()
    end, "Picker: Resume", { remap = true }),
    keybind.lazyKey("", "<leader>su", function()
      Snacks.picker.undo()
    end, "Picker: Undo History", { remap = true }),
    keybind.lazyKey("", "<leader>uC", function()
      Snacks.picker.colorschemes()
    end, "Picker: Colorschemes", { remap = true }),
  },
}
