local map = vim.keymap.set

map({ "n", "v", "x", "i" }, "<C-c>", "<Esc>")
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "Q", "<Nop>")
map("n", "q:", "<Nop>")
map("n", "<C-s>", "<cmd>w<CR>")
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-j>", "<cmd>cnext<CR>")
map("n", "<C-k>", "<cmd>cprev<CR>")

map("n", "<space>xx", "<cmd>source %<CR>")

-- Buffers
map("n", "]b", "<cmd>bn<CR>")
map("n", "[b", "<cmd>bp<CR>")
map("n", "<space>bd", "<cmd>bd<CR>")

-- Visual
map("x", "<", "<gv")
map("x", ">", ">gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")
