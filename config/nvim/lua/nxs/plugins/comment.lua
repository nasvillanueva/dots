return {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {
      ignore = '^$',
    },
    init = function()
      local ft = require('Comment.ft')

      ft.set('lua', {'-- %s', '--[[%s]]--'})
    end
  }
}
