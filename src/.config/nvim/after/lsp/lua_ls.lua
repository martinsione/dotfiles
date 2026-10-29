-- Teach lua_ls about the nvim runtime, unless the project has its own .luarc
return {
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
}
