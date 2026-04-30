vim.cmd("packadd nvim.undotree")
_G.nxs.keybind_set("n", "<leader>U", function()
  require("undotree").open({
    command = "50vnew",
  })
end, "Open undotree")

vim.pack.add({
  { src = _G.nxs.gh("everviolet/nvim"), name = "evergarden" },
  _G.nxs.gh("linrongbin16/lsp-progress.nvim"),
  _G.nxs.gh("nvim-lualine/lualine.nvim"),
  _G.nxs.gh("folke/which-key.nvim"),
  _G.nxs.gh("stevearc/oil.nvim"),
})

-- ==================================================================== colorscheme
vim.opt.background = "dark"

require("evergarden").setup({
  theme = { variant = "spring", accent = "green" },
})
vim.cmd("colorscheme evergarden")

-- ==================================================================== lsp progress
local lspProgress = require("lsp-progress")
lspProgress.setup({
  client_format = function(client_name, spinner)
    return {
      name = client_name,
      body = spinner,
    }
  end,
  format = function(client_messages)
    local active_clients = {}
    for _, msg in ipairs(client_messages) do
      active_clients[msg.name] = msg.body
    end

    local all_clients = vim.lsp.get_clients()
    if #all_clients == 0 then
      return ""
    end

    table.sort(all_clients, function(a, b)
      return a.name < b.name
    end)

    local builder = {}
    for _, client in ipairs(all_clients) do
      local spinner = active_clients[client.name]
      if spinner and spinner ~= "" then
        table.insert(builder, string.format("%s %s", client.name, spinner))
      else
        table.insert(builder, client.name)
      end
    end

    local sign = "" -- nf-fa-gear
    return sign .. " " .. table.concat(builder, ", ")
  end,
})

-- ==================================================================== lualine
local lualine = require("lualine")
lualine.setup({
  sections = {
    lualine_c = {
      {
        "filename",
        path = 3,
      },
    },
    lualine_x = {
      function()
        return lspProgress.progress()
      end,
      "filetype",
    },
  },
})

_G.nxs.new_autocmd("User", "LspProgressStatusUpdated", lualine.refresh)

-- ==================================================================== whickey
local wk = require("which-key")
vim.opt.timeout = true
vim.opt.timeoutlen = 300

wk.setup({
  preset = "helix",
  show_help = false,
})

wk.add({
  {
    mode = { "n", "v" },
    { "<leader><tab>", group = "tab" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "files" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>l", group = "lsp" },
    { "<leader>s", group = "search" },
    { "<leader>v", group = "nvim" },
    { "<leader>x", group = "quickfix/loclist" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
  },
})

-- ==================================================================== oil
require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  skip_confirm_for_simple_edits = true,
  lsp_file_methods = {
    enabled = true,
    autosave_changes = true,
  },
  keymaps = {
    ["<C-l>"] = false,
  },
})

_G.nxs.keybind_set("n", "<leader>e", "<CMD>Oil<CR>", "File Explorer")

local setup_deferred = _G.nxs.deferred_packadd({
  _G.nxs.gh("catgoose/nvim-colorizer.lua"),
  _G.nxs.gh("folke/trouble.nvim"),
  _G.nxs.gh("folke/todo-comments.nvim"),
})

setup_deferred(function()
  -- ==================================================================== colorizer
  require("colorizer").setup({
    -- Don't auto enable by filetype
    filetypes = {},
    options = {
      parsers = {
        css = true,
        css_fn = true,
        names = {
          enabled = false,
        },
        hex = {
          enabled = true,
          rgb = true,
          rrggbb = true,
        },
        tailwind = {
          enabled = true,
          lsp = true,
        },
      },
      display = {
        mode = "virtualtext",
        virtualtext = {
          position = "after",
        },
      },
    },
  })
end)
