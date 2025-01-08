return {
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({
        default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
        set_previous_events = {},
        async_switch_im = false,
        default_command = { "macism" },
      })
    end,
  },
}
