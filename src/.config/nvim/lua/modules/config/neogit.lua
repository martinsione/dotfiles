return function()
  local neogit = safe_require 'neogit'
  if not neogit then
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
