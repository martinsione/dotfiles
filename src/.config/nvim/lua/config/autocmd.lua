local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("FileType", {
  pattern = {
    "vim",
    "html",
    "css",
    "json",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "sh",
    "zsh",
  },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end,
})

autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
  end,
})

autocmd({ "BufNew", "BufNewFile", "BufRead" }, {
  pattern = "*.json",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.signcolumn = "no"
  end,
})

autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions + {
      c = false,
      o = false,
      r = true,
    }
  end,
})

autocmd("TextYankPost", {
  group = augroup("HighlightYank", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
