local M = {}

function M:init()
  local install_path = get_data_dir() .. '/site/pack/packer/start/packer.nvim'
  local package_root = get_data_dir() .. '/site/pack'
  local compile_path = get_data_dir() .. '/site/plugin/packer_compiled.lua'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
    require('packer').sync()
  end

  local ok, packer = safe_require 'packer'
  if not ok then
    return
  end

  packer.init {
    package_root = package_root,
    compile_path = compile_path,
    display = {
      open_fn = require('packer.util').float,
    },
  }

  self.packer = packer
  return self
end

function M:load(plugins)
  self:init()
  return self.packer.startup(function(use)
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end)
end

return M
