local opts = { noremap = true, silent = true }
local term_opts  = { slient = true } 

local keymap = vim.keymap.set

-- leader key --
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

keymap("", "H", "^", opts)
keymap("", "L", "$", opts)

keymap("n", "<F9>", ":set spell!<CR>", opts)
keymap("i", "<F9>", "<C-O>:set spell!<CR>", opts)

-- Normal Mode --
-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

keymap("n", "<leader>ff", "gg=G<CR>", opts)
keymap("n", "<leader>;", ":Buffers<CR>", opts)
keymap("n", "<leader>ta", ":tab ba<CR>", opts)
keymap("n", "<leader>fi", ":belowright split<CR>:term fish<CR>:resize 10<CR>", opts) -- open terminal 

-- open ranger in cwd
keymap("n", "<leader>F", ":RnvimrToggle<CR>", opts)

-- get rid of arrow keys
keymap("n", "<up>", "<nop>", opts)
keymap("n", "<down>", "<nop>", opts)
keymap("i", "<up>", "<nop>", opts)
keymap("i", "<down>", "<nop>", opts)
keymap("i", "<left>", "<nop>", opts)
keymap("i", "<right>", "<nop>", opts)

keymap("n", "<left>", ":bp<CR>", opts)
keymap("n", "<right>", ":bn<CR>", opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
