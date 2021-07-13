local utils = require('core.utils')
local packer_path = utils.os.data .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.cmd(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path
    )
end
vim.cmd('packadd packer.nvim ')

local packer = require('packer')
return packer.startup(function(use)
    packer.init({
        compile_path = utils.os.data .. '/site/plugin/packer_compiled.lua',
        opt_default = true,
        profile = { enable = true },
    })

    -- Plugin manager
    use({ 'wbthomason/packer.nvim' })

    -- Common dependencies
    use({
        'nvim-lua/plenary.nvim',
        module = 'plenary',
    })

    use({
        'nvim-lua/popup.nvim',
        module = 'popup',
    })

    -----[[------------]]-----
    ---     Essentials     ---
    -----]]------------[[-----
    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require('modules.config.nvim-treesitter'),
        requires = {
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        event = 'BufRead',
    })

    -----[[------------]]-----
    ---     UI Related     ---
    -----]]------------[[-----
    -- Start Screen
    use({
        'glepnir/dashboard-nvim',
        config = require('modules.config.dashboard-nvim'),
        cmd = 'Dashboard',
    })

    -- Colorschemes
    use({
        'npxbr/gruvbox.nvim',
        event = 'ColorSchemePre',
        requires = { { 'rktjmp/lush.nvim', module = 'lush' } },
    })
    use({ 'folke/tokyonight.nvim', event = 'ColorSchemePre' })

    -- Icons
    use({
        'kyazdani42/nvim-web-devicons',
        config = require('modules.config.nvim-web-devicons'),
        module = 'nvim-web-devicons',
    })

    -- File tree
    use({
        'kyazdani42/nvim-tree.lua',
        config = require('modules.config.nvim-tree'),
        cmd = {
            'NvimTreeClipboard',
            'NvimTreeClose',
            'NvimTreeFindFile',
            'NvimTreeOpen',
            'NvimTreeRefresh',
            'NvimTreeToggle',
        },
    })

    -- Statusline
    use({
        'glepnir/galaxyline.nvim',
        config = require('modules.config.galaxyline'),
        event = 'ColorScheme',
    })

    -- Tabline
    use({
        'akinsho/nvim-bufferline.lua',
        config = require('modules.config.nvim-bufferline'),
        event = 'ColorScheme',
    })

    -- Indent Lines
    use({
        'lukas-reineke/indent-blankline.nvim',
        config = require('modules.config.indent-blankline'),
        event = 'ColorScheme',
    })

    -----[[--------------]]-----
    ---     IDE features     ---
    -----]]--------------[[-----
    -- Autopairs
    use({
        'windwp/nvim-autopairs',
        config = require('modules.config.nvim-autopairs'),
        -- Should be loaded after nvim-compe, otherwise it is gonna complain
        -- about: "nvim-autopairs.completion.compe"
        after = 'nvim-compe',
    })

    -- Commenting
    use({
        'tpope/vim-commentary',
        event = 'BufEnter',
    })

    -- Should be included in vim core
    use({
        'tpope/vim-surround',
        event = 'BufEnter',
    })

    -- Fuzzy finding / Ctrl + p
    use({
        'nvim-telescope/telescope.nvim',
        config = require('modules.config.telescope'),
        requires = {
            { 'nvim-telescope/telescope-fzy-native.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        event = 'BufEnter',
        -- cmd = 'Telescope'
    })

    -----[[-------------]]-----
    ---     GIT RELATED     ---
    -----]]-------------[[-----
    use({
        'lewis6991/gitsigns.nvim',
        config = require('modules.config.gitsigns'),
        event = 'BufRead',
    })

    use({
        'TimUntersberger/neogit',
        config = require('modules.config.neogit'),
        requires = {
            { 'sindrets/diffview.nvim', module = 'diffview' },
        },
        cmd = 'Neogit',
    })

    -----[[------------]]-----
    ---     Completion     ---
    -----]]------------[[-----
    -- Built-in lsp
    use({
        'neovim/nvim-lspconfig',
        config = require('modules.config.nvim-lspconfig'),
        requires = {
            { 'kabouzeid/nvim-lspinstall', module = 'lspinstall' },
            { 'glepnir/lspsaga.nvim', module = 'lspsaga' },
            {
                'jose-elias-alvarez/nvim-lsp-ts-utils',
                module = 'nvim-lsp-ts-utils',
            },
        },
        event = 'ColorScheme',
    })

    -- Completion plugin
    use({
        'hrsh7th/nvim-compe',
        config = require('modules.config.nvim-compe'),
        event = 'InsertEnter',
        requires = {
            { 'ray-x/lsp_signature.nvim', module = 'lsp_signature' },
        },
    })

    -- Snippets
    use({
        'hrsh7th/vim-vsnip',
        requires = {
            'rafamadriz/friendly-snippets',
            'dsznajder/vscode-es7-javascript-react-snippets',
        },
        after = 'nvim-compe',
    })

    -----[[-------------]]-----
    ---     Web dev         ---
    -----]]-------------[[-----
    use({
        'norcalli/nvim-colorizer.lua',
        config = require('modules.config.nvim-colorizer'),
        event = 'ColorScheme',
    })

    packer.install()
    packer.compile()
end)
