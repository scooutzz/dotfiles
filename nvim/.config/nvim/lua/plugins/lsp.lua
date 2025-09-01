return {
  -- Completion sources
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/cmp-buffer"
  },
  {
    "hrsh7th/cmp-path"
  },

  -- Fast async formatting with Prettier
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier", stop_after_first = true },
          typescript = { "prettier", stop_after_first = true },
          javascriptreact = { "prettier", stop_after_first = true },
          typescriptreact = { "prettier", stop_after_first = true },
          vue = { "prettier", stop_after_first = true },
          css = { "prettier", stop_after_first = true },
          scss = { "prettier", stop_after_first = true },
          html = { "prettier", stop_after_first = true },
          json = { "prettier", stop_after_first = true },
          yaml = { "prettier", stop_after_first = true },
          markdown = { "prettier", stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- Mason tool installer for formatters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",    -- JavaScript/TypeScript/HTML/CSS formatter
          "prettierd",   -- Faster Prettier daemon
          "stylua",      -- Lua formatter
        },
      })
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",       -- TypeScript/JavaScript
          "html",        -- HTML
          "cssls",       -- CSS
          -- "eslint",      -- ESLint (temporarily disabled)
          "emmet_ls",    -- Emmet
          "lua_ls",      -- Lua
          "tailwindcss", -- Tailwind CSS
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- WORKAROUND: Fix for vim.fs.root ESLint issue in Neovim 0.11.2
      -- This prevents the fs.joinpath error by providing a safe fallback
      local original_root = vim.fs.root
      vim.fs.root = function(source, names)
        -- Ensure names is always a table of strings
        if type(names) == "string" then
          names = { names }
        elseif type(names) ~= "table" then
          return nil
        end
        
        -- Filter out any non-string values
        local safe_names = {}
        for _, name in ipairs(names) do
          if type(name) == "string" then
            table.insert(safe_names, name)
          end
        end
        
        if #safe_names == 0 then
          return nil
        end
        
        return original_root(source, safe_names)
      end

      -- Silence annoying notification handlers
      vim.lsp.handlers["window/showMessage"] = function() end
      vim.lsp.handlers["$/progress"] = function() end

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html" },
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      -- ESLint (re-enabled with fs.root workaround)
      lspconfig.eslint.setup({
        capabilities = capabilities,
      })

      -- Emmet (simplified)
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Tailwind CSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      -- Note: Auto format on save is now handled by conform.nvim above
      -- This provides much faster async formatting with Prettier

      -- LSP Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = ev.buf })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = ev.buf })
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = ev.buf })

          -- Information
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover info", buffer = ev.buf })
          vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = ev.buf })

          -- Actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions", buffer = ev.buf })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = ev.buf })
          vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ async = true, lsp_fallback = true })
          end, { desc = "Format buffer", buffer = ev.buf })

          -- Diagnostics
          vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float,
            { desc = "Show line diagnostics", buffer = ev.buf })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", buffer = ev.buf })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", buffer = ev.buf })
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic quickfix", buffer = ev.buf })
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN]  = "󰀪",
            [vim.diagnostic.severity.HINT]  = "󰌶",
            [vim.diagnostic.severity.INFO]  = "󰋽",
          }
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },
}

