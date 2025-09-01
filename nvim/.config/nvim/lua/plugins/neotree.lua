return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree" })

      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = { enabled = true, leave_dirs_open = false },
          hijack_netrw_behavior = "disabled",
          use_libuv_file_watcher = true,
        },

        default_component_configs = {
          -- TROCA o "[+]" do indicador de arquivo/buffer modificado
          modified = { symbol = "" }, -- ou "●", "✚", etc.

          name = { use_git_status_colors = true },

          git_status = {
            symbols = {
              added     = "✚",
              modified  = "",
              deleted   = "✖",
              renamed   = "",
              untracked = "",  -- aqui troca o "?"
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            },
          },
        },

        window = {
          position = "left",
          width = 30,
          mappings = {
            ["<space>"] = "none",
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { "add",  config = { show_path = "relative" } },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = { "copy", config = { show_path = "relative" } },
            ["m"] = { "move", config = { show_path = "relative" } },
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
          },
        },
      })
    end,
  }
}
