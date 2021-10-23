return function()
  local ok, neogit = safe_require 'neogit'
  if not ok then
    return
  end

  neogit.setup {
    disable_signs = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { '>', 'v' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = { diffview = true },
  }
end
