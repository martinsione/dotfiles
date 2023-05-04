-- return {
--   -- snippets
--   {
--     "L3MON4D3/LuaSnip",
--     build = (not jit.os:find("Windows"))
--         and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
--         or nil,
--     dependencies = {
--       "rafamadriz/friendly-snippets",
--       config = function()
--         require("luasnip.loaders.from_vscode").lazy_load()
--       end,
--     },
--     opts = {
--       history = true,
--       delete_check_events = "TextChanged",
--     },
--   },
--   {
--     "hrsh7th/nvim-cmp",
--     version = false, -- last release is way too old
--     event = "InsertEnter",
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-path",
--       "saadparwaiz1/cmp_luasnip",
--     },
--   },
--   {
--     "neovim/nvim-lspconfig",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       -- LSP Support
--       { "VonHeikemen/lsp-zero.nvim" },
--       { "williamboman/mason-lspconfig.nvim" },
--       { "williamboman/mason.nvim",          cmd = "Mason", build = ":MasonUpdate" },
--       { "hrsh7th/cmp-nvim-lsp" },
--     },
--     config = function()
--       local lsp = require("lsp-zero").preset("recommended")
--       local lspconfig = require("lspconfig")
--
--       lsp.ensure_installed({
--         "cssls",
--         "emmet_ls",
--         "eslint",
--         "jsonls",
--         "lua_ls",
--         "tailwindcss",
--         "tsserver",
--         --- linter
--         -- "eslint_d",
--         --- formatter
--         -- "stylua",
--         -- "prettierd",
--       })
--
--       -- Fix Undefined global 'vim'
--       -- lsp.configure("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
--       lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
--       lspconfig.eslint.setup({
--         filestypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
--         settings = {
--           format = { enable = true },
--           lint = { enable = true },
--         },
--       })
--
--       local cmp = require("cmp")
--       local luasnip = require("luasnip")
--
--       local has_words_before = function()
--         unpack = unpack or table.unpack
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--       end
--
--       local s = lsp.defaults.cmp.mappings({
--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
--         ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
--         ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
--         ["<C-e>"] = cmp.mapping.abort(),
--         ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--         ["<C-Space>"] = cmp.mapping.complete(),
--         ["<CR>"] = cmp.mapping({
--           i = function(fallback)
--             if cmp.visible() and cmp.get_active_entry() then
--               cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
--             else
--               fallback()
--             end
--           end,
--           s = cmp.mapping.confirm({ select = true }),
--           c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
--         }),
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--             -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--             -- they way you will only jump inside the snippet region
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           elseif has_words_before() then
--             cmp.complete()
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       })
--
--       lsp.setup_nvim_cmp({
--         mapping = s,
--         sources = {
--           { name = "nvim_lsp", keyword_length = 1 },
--           { name = "nvim_lua", keyword_length = 1 },
--           { name = "luasnip",  keyword_length = 2 },
--           { name = "path" },
--         },
--       })
--
--       vim.diagnostic.config({ virtual_text = true })
--
--       lsp.set_preferences({
--         suggest_lsp_servers = true,
--         sign_icons = { error = "E", warn = "W", hint = "H", info = "I" },
--       })
--
--       lsp.on_attach(function(client, bufnr)
--         local opts = { buffer = bufnr, remap = false }
--
--         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--         vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--         vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--         vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--         vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, opts)
--         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--         vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
--       end)
--
--       lsp.setup()
--     end,
--   },
--   {
--     "jose-elias-alvarez/null-ls.nvim",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = { "mason.nvim" },
--     config = function()
--       local null_ls = require("null-ls")
--       local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--       null_ls.setup({
--         root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
--         sources = {
--           null_ls.builtins.formatting.stylua,
--           null_ls.builtins.formatting.prettierd,
--           null_ls.builtins.diagnostics.eslint_d,
--           null_ls.builtins.code_actions.eslint_d,
--         },
--         on_attach = function(client, bufnr)
--           if client.supports_method("textDocument/formatting") then
--             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--             vim.api.nvim_create_autocmd("BufWritePre", {
--               group = augroup,
--               buffer = bufnr,
--               callback = function()
--                 -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--                 vim.lsp.buf.format()
--               end,
--             })
--           end
--         end,
--       })
--     end,
--   },
-- }
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Support
      { "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function(_, opts) end,
      },
    },

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        },
        tailwindcss = {},
      },
    },
    config = function(_, opts)
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      local lsp_config = require("lspconfig")

      local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lsp_attach = function(_client, bufnr)
        local key_opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, key_opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, key_opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, key_opts)
        vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, key_opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key_opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key_opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, key_opts)
      end

      mason_lspconfig.setup({
        ensure_installed = {
          "cssls",
          "emmet_ls",
          "eslint",
          "jsonls",
          "lua_ls",
          "tailwindcss",
          "tsserver",
          --- linter
          -- "eslint_d",
          --- formatter
          -- "stylua",
          -- "prettierd",
        },
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          lsp_config[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
            settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
          })
        end,
      })

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    -- dependencies = {
    --   "rafamadriz/friendly-snippets",
    --   config = function()
    --     require("luasnip.loaders.from_vscode").lazy_load()
    --   end,
    -- },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      local compare = require("cmp.config.compare")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1 },
          { name = "luasnip", priority = 5, keyword_length = 2 },
          -- { name = "buffer", priority = 10, keyword_length = 3 },
          { name = "path", priority = 2 },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
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
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.format()
              end,
            })
          end
        end,
      })
    end,
  },
}
