return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
      },
    },
    config = function()
      local autocmd = vim.api.nvim_create_autocmd
      local highlight = vim.lsp.protocol.Methods.textDocument_documentHighlight
      local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
      autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local builtin = require("telescope.builtin")

          map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("gr", builtin.lsp_references, "[G]oto [R]eferences")
          map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
          map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
          map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(highlight) then
            -- one set per buffer, even when several clients support highlights
            vim.api.nvim_clear_autocmds({ group = hl_group, buffer = event.buf })
            autocmd({ "CursorHold", "CursorHoldI" }, {
              group = hl_group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "CursorMovedI" }, {
              group = hl_group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event)
          -- keep highlights while another client still provides them
          for _, c in ipairs(vim.lsp.get_clients({ bufnr = event.buf, method = highlight })) do
            if c.id ~= event.data.client_id then
              return
            end
          end
          vim.lsp.util.buf_clear_references(event.buf)
          vim.api.nvim_clear_autocmds({ group = hl_group, buffer = event.buf })
        end,
      })

      require("mason").setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "vtsls", "tailwindcss" },
        -- formatter-only servers; conform already runs these
        automatic_enable = { exclude = { "oxfmt", "stylua" } },
      })

      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs({ "oxfmt", "stylua" }) do
          if mr.has_package(tool) then
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end
      end)
    end,
  },
}
