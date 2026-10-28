vim.loader.enable() -- byte-compile and cache lua modules (lazy.nvim used to turn this on)

-- 'background' comes from the terminal (OSC 11) and follows its theme changes (DEC mode 2031);
-- through tmux that needs a current tmux server (3.8+) and freshly attached clients, or it
-- reports a stale theme. Don't set it here: that disables nvim's detection entirely
vim.cmd.colorscheme("vercel")

require("config.options")
require("config.keymaps")
require("config.autocmd")

-- Build hooks have to exist before vim.pack.add() so they also run on first install
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

require("plugins.treesitter")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.editor")
