return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {},
    })

    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    local lspconfig = require("lspconfig")

    require("fidget").setup({})

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "vue_ls",
        "vtsls",
        "eslint",
        "html",
        "emmet_ls",
      },
      handlers = {
        -- Default handler
        function(server_name)
          local lsp = require("lspconfig")[server_name]
          if lsp then
            lsp.setup({
              capabilities = capabilities,
            })
          end
        end,

        ["vue_ls"] = function()
          require("lspconfig").vue_ls.setup({
            capabilities = capabilities,
            init_options = {
              typescript = {
                serverPath = "/home/relaxou/.nvm/versions/node/v20.17.0/bin/vtsls",
              }
            }
          })
        end,

        ["vtsls"] = function()
          require("lspconfig").vtsls.setup({
            capabilities = capabilities,
          })
        end,

        ["eslint"] = function()
          lspconfig.eslint.setup({
            capabilities = capabilities,
            filetypes = { "vue", "typescript", "javascript" },
          })
        end,

        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
              "html",
              "typescriptreact",
              "javascriptreact",
              "css",
              "sass",
              "scss",
              "less",
              "svelte",
            },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,

        ["html"] = function()
          lspconfig.html.setup({
            capabilities = capabilities,
          })
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
          { name = "buffer" },
        }),
    })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, {})
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
  end,
}

