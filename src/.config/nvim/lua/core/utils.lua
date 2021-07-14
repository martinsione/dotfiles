local M = {}

-- Os
M.os = {
    home = os.getenv('HOME'),
    data = vim.fn.stdpath('data'),
    cache = vim.fn.stdpath('cache'),
    config = vim.fn.stdpath('config'),
    name = vim.loop.os_uname().sysname,
    is_git_dir = os.execute(
        'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
    ),
}

function M.term_wrapper(cmd, fmt)
    -- NOTE: Run command accepts 2 params
    -- 1: Default terminal command, between quotes
    -- 2: Optional: a string format argument with %
    -- Eg: term_wrapper('echo I am editing %s', vim.fn.expand("%"))
    vim.cmd('vnew')
    vim.cmd('term ' .. string.format(cmd, fmt))
    vim.cmd('silent! file CompileAndRun')
    vim.cmd('set nobuflisted')
    vim.cmd('setl nornu nonu nocul so=0 scl=no')
    vim.cmd('startinsert')
end

local is_transparent = true
function M.toogle_background()
    if is_transparent == true then
        vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
        is_transparent = false
    else
        vim.cmd([[ set background=dark ]])
        is_transparent = true
    end
end

-- Mappings
M.keymap = {}
function M.keymap.buf_map(mode, key, cmd, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_buf_set_keymap(0, mode, key, cmd, options)
end

function M.keymap.map(mode, key, cmd, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, cmd, options)
end

return M
