-- Options, keymaps and the plugin list. Plugin setup lives in plugin/*.lua (sourced after this file),
-- language server overrides in after/lsp/*.lua (merged over nvim-lspconfig's lsp/*.lua).
vim.loader.enable() -- byte-compile and cache lua modules

-- 'background' comes from the terminal (OSC 11) and follows its theme changes (DEC mode 2031);
-- through tmux that needs a current tmux server (3.8+) and freshly attached clients, or it
-- reports a stale theme. Don't set it here: that disables nvim's detection entirely
vim.cmd.colorscheme("vercel")

-- Options
vim.g.mapleader = " "
vim.g.loaded_netrw = 1 -- neo-tree replaces it
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- nvim only falls back to OSC 52 on its own when 'clipboard' is empty, so ask for it over ssh
if vim.env.SSH_TTY then
  vim.g.clipboard = "osc52"
end
opt.completeopt = "menuone,noselect,popup" -- popup shows docs for the selected LSP item
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.cursorline = true
opt.expandtab = true
opt.fillchars = { diff = "╱", eob = " " }
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepprg = "rg --vimgrep" -- default adds -uu, which greps ignored files
opt.ignorecase = true
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false

-- Keymaps (plugin keymaps live next to their setup in plugin/)
local map = vim.keymap.set

map({ "n", "v", "i" }, "<C-c>", "<Esc>")
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "Q", "<Nop>")
map("n", "q:", "<Nop>")
map("n", "<C-s>", "<cmd>w<CR>")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })

-- Completion (LSP autocompletion is enabled per buffer in plugin/lsp.lua)
-- <CR> accepts like <C-y>, picking the first item when none is selected yet
map("i", "<CR>", function()
  if vim.fn.pumvisible() == 0 then
    return "<CR>"
  end
  return vim.fn.complete_info({ "selected" }).selected == -1 and "<C-n><C-y>" or "<C-y>"
end, { expr = true })
map("i", "<C-Space>", vim.lsp.completion.get)

map("n", "<C-j>", "<cmd>cnext<CR>")
map("n", "<C-k>", "<cmd>cprev<CR>")

map("n", "<space>xx", "<cmd>source %<CR>")

-- Buffers (]b/[b are built in)
map("n", "<space>bd", "<cmd>bd<CR>")

-- Visual
map("x", "<", "<gv")
map("x", ">", ">gv")
map("x", "J", ":m '>+1<CR>gv=gv")
map("x", "K", ":m '<-2<CR>gv=gv")

map("n", "<space>cfp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied path: " .. path)
end, { desc = "Copy current file path" })

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Plugins. Build hooks have to exist before vim.pack.add() so they also run on first install
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end
    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- Update with :lua vim.pack.update(); versions are pinned in nvim-pack-lock.json
local gh = function(repo)
  return "https://github.com/" .. repo
end
vim.pack.add({
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("MunifTanjim/nui.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("neovim/nvim-lspconfig"),
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("nvim-neo-tree/neo-tree.nvim"),
  gh("MeanderingProgrammer/render-markdown.nvim"),
})
