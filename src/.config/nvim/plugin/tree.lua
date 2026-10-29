require("neo-tree").setup({
  close_if_last_window = true,
  event_handlers = {
    {
      -- follow_current_file, minus node_modules: neo-tree never frees the thousands of nodes it loads there
      event = "vim_buffer_enter",
      handler = function()
        if vim.bo.buftype == "" and not vim.api.nvim_buf_get_name(0):find("/node_modules/", 1, true) then
          require("neo-tree.sources.filesystem").follow()
        end
      end,
    },
  },
  filesystem = {
    bind_to_cwd = true,
    filtered_items = { hide_dotfiles = false, hide_gitignored = false, hide_hidden = false },
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["l"] = "open",
      },
    },
  },
  window = { position = "right" },
})
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle reveal<cr>", { desc = "NeoTree" })
