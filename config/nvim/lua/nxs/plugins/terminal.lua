return {
  {
    "numToStr/FTerm.nvim",
    keys = {
      {
        "<C-Space>",
        function()
          require("FTerm").toggle()
        end,
        mode = { "n", "t" },
        desc = "Open floating terminal",
      },
    },
  }
}
