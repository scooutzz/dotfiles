return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<M-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<M-j>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<M-k>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<M-l>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<M-;>", function() harpoon:list():select(4) end)
  end
}
