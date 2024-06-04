return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "diegoulloao/neofusion.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = require("neofusion.lualine"),
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_b = { "diagnostics" },
          lualine_c = {
            { "filename", path = 3 },
          },
          lualine_x = {
            "branch",
            {
              function()
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()

                if next(clients) == nil then
                  return buf_ft
                end

                local active_lsp = {}
                for _, client in ipairs(clients) do
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
