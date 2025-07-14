return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    branch = "master",
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities()
      )

      -- configure mason-lspconfig ensure_installed

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = os.getenv("HOME") .. "/.local/share/nvm/v20.17.0/lib/node_modules/@vue/typescript-plugin",
              -- location = require('mason_registry').get_package('vue-language-server'):get_install_path() ..  '/node_modules/@vue/language-server',
              languages = { "vue" },
            },
          },
        },
        cmd = { "typescript-language-server", "--stdio" },
      })

      lspconfig.vuels.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
    end,
  },
}
