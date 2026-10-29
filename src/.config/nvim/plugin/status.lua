-- Tell the terminal what nvim is doing (OSC 7501, https://www.superlogical.com/rex/docs/build/program-status):
-- working while a language server reports progress, idle otherwise. Terminals that don't know it ignore it.
local last
local function report(state, msg, progress)
  local body = "state=" .. state .. ":app=nvim"
  if progress then
    body = body .. ":progress=" .. math.floor(progress)
  end
  if msg then
    body = body .. ":msg=" .. vim.base64.encode((msg:gsub("%c", " ")):sub(1, 200))
  end
  if body ~= last then
    last = body
    vim.api.nvim_ui_send("\027]7501;" .. body .. "\027\\")
  end
end

local active = {} -- "<client>:<token>" -> latest progress value, until its "end"
vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("program-status", { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value
    if type(value) ~= "table" then
      return
    end
    local key = ev.data.client_id .. ":" .. tostring(ev.data.params.token)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    active[key] = value.kind ~= "end"
        and vim.tbl_extend("force", active[key] or {}, value, {
          client = client and client.name or "lsp",
        })
      or nil

    local _, current = next(active)
    if not current then
      return report("idle")
    end
    local msg = current.client .. ": " .. (current.title or "") .. (current.message and (" " .. current.message) or "")
    report("working", msg, current.percentage)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = "program-status",
  callback = function()
    report("idle")
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = "program-status",
  callback = function()
    report("clear")
  end,
})
