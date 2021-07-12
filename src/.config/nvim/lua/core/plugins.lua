local packer_path = U.os.data .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.cmd(
        "!git clone https://github.com/wbthomason/packer.nvim " .. packer_path
    )
end
vim.cmd "packadd packer.nvim"
vim.opt.rtp = vim.opt.rtp + (U.os.data .. "/site/pack/packer/opt/*")
local packer = require "packer"
local packer_compiled = U.os.data .. "/site/plugin/packer_compiled.lua"

return packer.startup(function(use)
    packer.init {
        compile_path = packer_compiled,
        opt_default = true,
        profile = { enable = true },
    }

    use {
        "wbthomason/packer.nvim",
        opt = true,
    }
    use {
        "akinsho/nvim-bufferline.lua",
        setup = [[require('plugin.nvim-bufferline')]],
    }
    use {
        "glepnir/dashboard-nvim",
        setup = [[require('plugin.dashboard-nvim')]],
    }
    use {
        "glepnir/galaxyline.nvim",
        setup = [[require('plugin.galaxyline')]],
    }
    use {
        "kyazdani42/nvim-tree.lua",
        setup = [[require('plugin.nvim-tree')]],
    }
    use {
        "kyazdani42/nvim-web-devicons",
        setup = [[require('plugin.nvim-web-devicons')]],
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        setup = [[require('plugin.indent-blankline')]],
    }
    use {
        "norcalli/nvim-colorizer.lua",
        setup = [[require('plugin.nvim-colorizer')]],
    }
    use { "windwp/nvim-autopairs", setup = [[require('plugin.nvim-autopairs')]] }
    use "tpope/vim-commentary"
    use "tpope/vim-surround"
    use {
        -- Colorschemes
        { "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
        "folke/tokyonight.nvim",
        "glepnir/zephyr-nvim",
        -- 'ChristianChiarulli/nvcode-color-schemes.vim',
    }
    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        setup = [[require('plugin.gitsigns')]],
    }
    use {
        "TimUntersberger/neogit",
        setup = [[require('plugin.neogit')]],
    }
    use "sindrets/diffview.nvim"
    use {
        -- Lsp
        "neovim/nvim-lspconfig",
        setup = [[require('plugin.nvim-lspconfig')]],
        requires = {
            "glepnir/lspsaga.nvim",
            "jose-elias-alvarez/nvim-lsp-ts-utils",
            "kabouzeid/nvim-lspinstall",
            {
                "hrsh7th/nvim-compe",
                setup = [[require('plugin.nvim-compe')]],
                event = "InsertEnter",
            },
            { -- Snippets
                "hrsh7th/vim-vsnip",
                event = "InsertEnter",
                requires = {
                    "rafamadriz/friendly-snippets",
                    "dsznajder/vscode-es7-javascript-react-snippets",
                },
            },
        },
    }
    use {
        -- Telescope
        "nvim-telescope/telescope.nvim",
        setup = [[require('plugin.telescope')]],
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
        },
    }
    use {
        -- Treesitter
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        setup = [[require('plugin.nvim-treesitter')]],
        requires = {
            "p00f/nvim-ts-rainbow",
            "windwp/nvim-ts-autotag",
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
    }

    -- Autoinstall/compile plugins
    packer.install()
    packer.compile()
end)
