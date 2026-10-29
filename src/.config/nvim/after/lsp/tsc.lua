-- TypeScript 7's native server (tsc --lsp), from the project's node_modules; projects on older TypeScript
-- get no TS server. Own cmd/root_dir: lspconfig's warns when the project has no TS 7, and its binary cache
-- doesn't survive the config being reloaded, so it ends up starting a global tsc.
return {
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
}
