require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = '▋'},
    change       = {hl = 'GitGutterChange', text = '▋'},
    delete       = {hl = 'GitGutterDelete', text = '▋'},
    topdelete    = {hl = 'GitGutterDelete', text = '▘'},
    changedelete = {hl = 'GitGutterChange', text = '▋'},
  }
}
