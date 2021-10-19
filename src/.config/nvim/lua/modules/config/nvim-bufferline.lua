local ok, bufferline = safe_require 'bufferline'
if not ok then
  return
end

bufferline.setup {
  options = {
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is deduplicated
    tab_size = 20,
    offsets = { { filetype = 'NvimTree' } },
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'thin',
    always_show_bufferline = true,
  },
}
