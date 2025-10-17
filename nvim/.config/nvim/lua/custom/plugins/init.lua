-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Copilot
    'github/copilot.vim',
  },

  { -- Highlight colors
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup {}
    end,
  },

  { -- Git fugitive
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [s]tatus' })
    end,
  },

  { -- Undo tree
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [u]ndotree' })
    end,
  },

  { -- Vim Be Good
    'theprimeagen/vim-be-good',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() end,
  },
}
