local autocmd = vim.api.nvim_create_autocmd
local highlight = vim.lsp.protocol.Methods.textDocument_documentHighlight
local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
local formatters = { oxfmt = true, stylua = true }

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

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      -- complete as you type, not only on the server's triggerCharacters (see :h lsp-autocompletion)
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

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

-- Format on save with the formatter servers only; they attach where the project configures them
autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("lsp-format", { clear = true }),
  callback = function(args)
    local filter = function(c)
      return formatters[c.name]
    end
    if #vim.tbl_filter(filter, vim.lsp.get_clients({ bufnr = args.buf })) > 0 then
      vim.lsp.buf.format({ bufnr = args.buf, filter = filter, timeout_ms = 500 })
    end
  end,
})

vim.lsp.config("lua_ls", {
  -- what lazydev did: teach lua_ls about the nvim runtime, unless the project has its own .luarc
  on_init = function(client)
    local root = client.workspace_folders and client.workspace_folders[1].name
    if root and (vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc")) then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" } },
    })
  end,
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
    },
  },
})

-- Servers come from the system package manager (install/packages); TypeScript and oxfmt come from each
-- project's node_modules. lspconfig's root_dir picks the project folder a server starts in, and starts
-- <folder>/node_modules/.bin/<server>, falling back to a global binary (we install none) or a warning.
-- So only let them attach when that folder has its own copy.

-- tsc --lsp is TypeScript 7's native server; projects on older TypeScript get no TS server.
-- Own root_dir/cmd: lspconfig's warns when the project has no TS 7, and its binary cache doesn't survive
-- the config being reloaded, so it ends up starting a global tsc. Root: lockfile folder, else .git
vim.lsp.config("tsc", {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start(
      { vim.fs.joinpath(config.root_dir, "node_modules/.bin/tsc"), "--lsp", "--stdio" },
      dispatchers
    )
  end,
  root_dir = function(bufnr, on_dir)
    local lockfiles = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    local root = vim.fs.root(bufnr, { lockfiles, { ".git" } })
    local ok, major = pcall(function()
      local pkg = vim.fs.joinpath(root, "node_modules/typescript/package.json")
      return tonumber(vim.json.decode(table.concat(vim.fn.readfile(pkg), "\n")).version:match("^(%d+)"))
    end)
    if root and ok and major and major >= 7 then
      on_dir(root)
    end
  end,
})

local oxfmt_root_dir = vim.lsp.config.oxfmt.root_dir
vim.lsp.config("oxfmt", {
  root_dir = function(bufnr, on_dir)
    oxfmt_root_dir(bufnr, function(root)
      if root and vim.fn.executable(vim.fs.joinpath(root, "node_modules/.bin/oxfmt")) == 1 then
        on_dir(root)
      end
    end)
  end,
})

vim.lsp.enable({ "lua_ls", "tsc", "tailwindcss", "oxfmt", "stylua" })
