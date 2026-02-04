return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "VeryLazy" },
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup()

      local ignored_parsers = {}
      local parsers = {}

      if #ignored_parsers > 0 then
        for _, v in ipairs(ts.get_available()) do
          if not vim.tbl_contains(ignored_parsers, v) then
            table.insert(parsers, v)
          end
        end
      else
        parsers = ts.get_available()
      end

      ts.install(parsers)

      local excluded_fts = { "dockerfile" }

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if vim.tbl_contains(excluded_fts, args.match) then
            return
          end

          local started = pcall(vim.treesitter.start)

          if started then
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldenable = false

            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "VeryLazy" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
