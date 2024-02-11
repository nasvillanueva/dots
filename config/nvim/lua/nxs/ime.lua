local lazyload = require("nxs.utils.lazyload")

lazyload.add(function()
  require("im_select").setup({
    default_im_select = "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman",
  })
end)
