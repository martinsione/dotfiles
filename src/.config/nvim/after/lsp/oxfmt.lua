-- Start in the nearest folder that has oxfmt installed; lspconfig runs <root>/node_modules/.bin/oxfmt and
-- would otherwise fall back to a global oxfmt (there is none). oxfmt finds its own config per file.
return {
  root_dir = function(bufnr, on_dir)
    local path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    local bin = vim.fs.find("node_modules/.bin/oxfmt", { path = path, upward = true })[1]
    if bin then
      on_dir((bin:gsub("/node_modules/%.bin/oxfmt$", "")))
    end
  end,
}
