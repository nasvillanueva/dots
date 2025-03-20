local icon_by_string = {
  ["oil:"] = "",
  ["term:"] = "",
  ["NvimTree_1"] = "",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rose-pine/neovim",
    },
    config = function()
      local palette = require("rose-pine.palette")
      require("lualine").setup({
        options = {
          theme = "rose-pine",
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_b = { "diagnostics" },
          lualine_c = {},
          lualine_x = {
            "branch",
          },
          lualine_y = {},
        },
        inactive_sections = {},
        tabline = {
          lualine_c = {
            {
              function()
                local path = vim.fn.expand("%:p:~")
                local crumbs = {}

                for crumb in string.gmatch(path, "([^/]+)") do
                  local icon = icon_by_string[crumb]

                  if icon then
                    table.insert(crumbs, icon)
                  else
                    table.insert(crumbs, crumb)
                  end
                end

                return table.concat(crumbs, " ⟩ ")
              end,
              color = { bg = palette.rose, fg = palette.base, gui = "bold" },
            },
          },
          lualine_x = {
            {
              function()
                local buf_ft = vim.api.nvim_get_option_value("filetype", {
                  buf = 0,
                })
                local clients = vim.lsp.get_clients()

                if next(clients) == nil then
                  return buf_ft
                end

                local active_lsp = {}
                for _, client in ipairs(clients) do
                  if client.name == "copilot" then
                    table.insert(active_lsp, "copilot")
                  end

                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    table.insert(active_lsp, client.name)
                  end
                end
                if #active_lsp == 0 then
                  return buf_ft
                end

                return buf_ft .. ": " .. table.concat(active_lsp, ", ")
              end,
              icon = "",
            },
          },
        },
      })
    end,
  },
}
