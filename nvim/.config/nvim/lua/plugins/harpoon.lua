return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts =  {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local harpoon = require("harpoon")
    local keys = {
      { "<leader>a", function() harpoon:list():add() end, desc = "Harpoon Add to List" },
      { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Quick Menu" },
    }


    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function ()
          harpoon:list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
  -- config = function()
  --   local harpoon = require("harpoon")
  --
  --   vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
  --   vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  --
  --   vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
  --   vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
  --   vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
  --   vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)
  -- end
}
