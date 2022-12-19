vim.cmd [[colorscheme onedark]]

-- Autocmds
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
    group = augroup('HighlightYank', {}),
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
    end,
})


-- Opts
local o = vim.opt
o.colorcolumn = '80'
o.cursorline = true
o.number = true
o.relativenumber = true
o.ruler = false
o.showmode = false
o.signcolumn = 'yes'
o.termguicolors = true
o.updatetime = 100

o.backup = false
o.writebackup = false
o.swapfile = false

o.clipboard = 'unnamedplus'
o.scrolloff = 8
o.splitbelow = true
o.splitright = true
o.virtualedit = 'block'

-- Search
o.inccommand = 'nosplit'
o.ignorecase = true
o.smartcase = true
o.wildignore = { '.git/*', 'node_modules/*' }
o.wildignorecase = true

-- Tabs
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Shortmess
o.shortmess = o.shortmess
    + {
        A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
        I = true, -- don't give the intro message when starting Vim |:intro|.
        W = true, -- don't give "written" or "[w]" when writing a file
        c = true, -- don't give |ins-completion-menu| messages
        m = true, -- use "[+]" instead of "[Modified]"
    }

-- Format options
o.formatoptions = o.formatoptions
    + {
        c = false,
        o = false, -- O and o, don't continue comments
        r = true, -- Pressing Enter will continue comments
    }

-- Remove builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1



-- Maps
vim.g.mapleader = " "
local map = vim.keymap.set
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', 'Q', '<Nop>')
map('n', 'q:', '<Nop>')
map('n', '<C-c>', '<Esc>')
map('n', '<C-s>', '<cmd>w<CR>')
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', '<CR>', '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- Buffers
map('n', '<Tab>', '<cmd>bn<CR>')
map('n', '<S-Tab>', '<cmd>bp<CR>')
map('n', '<space>bd', '<cmd>bd<CR>')



-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

packer.init({
    compile_path = vim.fn.stdpath 'data' .. '/site/plugin/packer_compiled.lua',
})

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'navarasu/onedark.nvim'

    use 'tpope/vim-surround'

    use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }

    use { 'nvim-telescope/telescope.nvim', branch = '0.1.0', requires = { { 'nvim-lua/plenary.nvim' } } }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,


        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason-lspconfig.nvim' },
                { 'williamboman/mason.nvim' },
                -- Autocompletion
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/nvim-cmp' },
                { 'saadparwaiz1/cmp_luasnip' },
                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            }
        }
    }
end)
