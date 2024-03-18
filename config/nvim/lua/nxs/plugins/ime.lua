return {
  {
    "keaising/im-select.nvim",
    event = "BufReadPost",
    main = "im_select",
    opts = {
      default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
    },
  },
}
