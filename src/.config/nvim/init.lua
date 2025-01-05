--[[ Original Config
require("config.autocmd")
require("config.options")
require("config.keymaps")
require("config.lazy")
]]--

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.o.scrolloff = 8
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.g.have_nerd_font = false
vim.o.breakindent = true -- Enable break indent
vim.o.updatetime = 250 -- Decrease update time
vim.o.ruler = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Columns
vim.o.colorcolumn = "80"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

-- Search
vim.o.smartcase = true
vim.o.ignorecase = true
-- vim.o.wildignore = { ".git/*", "node_modules/*" }
vim.o.wildignorecase = true

-- Tabs
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

vim.opt.shortmess = vim.opt.shortmess
  + {
    A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
    I = true, -- don't give the intro message when starting Vim |:intro|.
    W = true, -- don't give "written" or "[w]" when writing a file
    c = true, -- don't give |ins-completion-menu| messages
    m = true, -- use "[+]" instead of "[Modified]"
  }

vim.opt.formatoptions = vim.opt.formatoptions
  + {
    c = false,
    o = false, -- O and o, don't continue comments
    r = true, -- Pressing Enter will continue comments
  }

--
-- Mappings
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "Q", "<Nop>")
map("n", "q:", "<Nop>")
map("n", "<C-c>", "<Esc>")
map("n", "<C-s>", "<cmd>w<CR>")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true, desc = "Clear search highlighting" })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Buffers
map("n", "]b", "<cmd>bn<CR>")
map("n", "[b", "<cmd>bp<CR>")
map("n", "<space>bd", "<cmd>bd<CR>")
-- Visual
map("x", "<", "<gv")
map("x", ">", ">gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")


--
-- Autocmd
--
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  group = augroup("HighlightYank", { clear = true }),
  pattern = "*",
  desc = "Highlight when yanking (copying) text",
})

autocmd("FileType", {
  pattern = {
    "vim",
    "html",
    "css",
    "json",
    "javascript",
    "javascriptreact",
    "markdown.mdx",
    "typescript",
    "typescriptreact",
    "lua",
    "sh",
    "zsh",
  },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end,
})

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
  end,
})

autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
  pattern = "*.json",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
  end,
})
