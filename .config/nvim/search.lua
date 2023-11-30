local opts      = { noremap = true, silent = true }
local term_opts = { slient = true }
local keymap    = vim.keymap.set


vim.cmd [[ let g:fzf_layout = { 'down': '40%' } ]]

-- RG
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg = 'rg --no-heading --vimgrep'
  vim.o.grepformat = '%f:%l:%c:%m'
end

keymap("n", "<leader>s", ":Rg<CR>", opts)
vim.cmd [[
	command! -bang -nargs=* Rg
				\ call fzf#vim#grep(
				\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
				\   <bang>0 ? fzf#vim#with_preview('up:60%')
				\           : fzf#vim#with_preview('right:50%:hidden', '?'),
				\   <bang>0)
]]

local status_ok, builtin = pcall(require, 'telescope.builtin')
if not status_ok then
  return
end

-- telescope
keymap("", "<C-p>", builtin.find_files, {})
keymap("", "<C-g>", builtin.git_files, {})
keymap("", "<C-u>", vim.cmd.UndotreeToggle, {})
-- fzf
keymap("", "<C-M-p>", ":FZF<CR>", opts)
