local M = {}

function M:init(opts)
  opts = opts or {}

  local install_path = opts.install_path or vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
  local compile_path = opts.compile_path or vim.fn.stdpath 'data' .. '/site/plugin/packer_compiled.lua'
  local package_root = opts.package_root or vim.fn.stdpath 'data' .. '/site/pack'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
  end

  local ok, packer = pcall(require, 'packer')
  if not ok then
    return
  end

  packer.init {
    compile_path = compile_path,
    package_root = package_root,
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  self.packer = packer
  return self
end

function M:load(plugins)
  return self.packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end)
end

return M
