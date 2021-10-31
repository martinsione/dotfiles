return function()
  local autopairs = safe_require 'nvim-autopairs'
  if not autopairs then
    return
  end

  autopairs.setup {}
end
