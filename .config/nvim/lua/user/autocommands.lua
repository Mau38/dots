vim.cmd[[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua require('vim.lsp').buf_format_if_not_in_directory()
  augroup end
]]

-- Inline function definition
vim.lsp.buf_format_if_not_in_directory = function()
  -- Specify the directory to exclude from formatting
  local excluded_directory = "~/Desktop/ValorCode/"

  -- Get the current file path
  local current_file = vim.fn.expand("%:p")

  -- Check if the file is not in the excluded directory
  if vim.fn.isdirectory(excluded_directory) == 1 and vim.fn.match(current_file, excluded_directory) ~= 1 then
    vim.lsp.buf.format()
  end
end

