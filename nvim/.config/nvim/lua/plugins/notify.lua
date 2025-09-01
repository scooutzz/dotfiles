return {
  "rcarriga/nvim-notify",
  opt = {
  },
  config = function()
    require("notify").setup({
      stages = "static",
      timeout = 2000,
      render = "wrapped-compact",
      top_down = true,
      max_width = 50,
    })

    vim.notify = require "notify"
  end,
}
