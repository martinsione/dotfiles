vim.o.completeopt = "menuone,noselect"

require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "always", -- 'enable' / 'always'
  -- throttle_time = 80,
  -- source_timeout = 200,
  -- resolve_timeout = 800,
  -- incomplete_delay = 400,
  -- max_abbr_width = 100,
  -- max_kind_width = 100,
  -- max_menu_width = 100,
  -- documentation = {
  --   border = 'none', -- the border option is the same as `|help nvim_open_win|`
  --   winhighlight = 'CompeDocumentation', -- highlight group used for the documentation window
  --   max_width = 120,
  --   min_width = 40,
  --   max_height = math.floor(vim.o.lines * 0.3),
  --   min_height = 1,
  -- },
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true,
    emoji = true,
  },
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", { 1 }) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", { -1 }) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

U.keymap.map("i", "<Tab>", "v:lua.tab_complete()", { expr = true, noremap = false })
U.keymap.map("s", "<Tab>", "v:lua.tab_complete()", { expr = true, noremap = false })
U.keymap.map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true, noremap = false })
U.keymap.map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true, noremap = false })
U.keymap.map("i", "<C-Space>", "compe#complete()", { expr = true })
U.keymap.map("i", "<C-e>", "compe#close()", { expr = true })
