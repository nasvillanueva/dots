require("nxs.plugins.db.config")
local keybind = require("nxs.utils.keybind")

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    keys = {
      keybind.lazyKey(
        "n",
        "<leader>D",
        "<cmd>DBUITabToggle<CR>",
        "Toggle DBUI in a tab"
      ),
    },
    config = function()
      vim.api.nvim_create_user_command("DBUITabToggle", function()
        -- Look for an existing tab with a DBUI buffer
        for tabnr = 1, vim.fn.tabpagenr("$") do
          for _, bufnr in ipairs(vim.fn.tabpagebuflist(tabnr)) do
            local name = vim.api.nvim_buf_get_name(bufnr)
            if name:match("dbui") then
              -- If we're already in that tab, close it
              if vim.fn.tabpagenr() == tabnr then
                vim.cmd("tabclose")
              else
                -- Otherwise switch to it
                vim.cmd("tabnext " .. tabnr)
              end
              return
            end
          end
        end

        -- If no DBUI tab exists, open one
        vim.cmd("tabnew | DBUI")
      end, {})
    end,
    init = function()
      local data_path = vim.fn.stdpath("data")

      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
}
