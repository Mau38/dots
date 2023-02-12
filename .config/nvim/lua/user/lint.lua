-- comments
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
    if not status_utils_ok then
      return
    end

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = utils.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = utils.get_visual_start_location()
    end

    local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
    if not status_internals_ok then
      return
    end

    return internals.calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}

-- auto tags
local ok, auto_tag = pcall(require, 'nvim-ts-autotag')
if not ok then 
	return
end
auto_tag.setup()

-- tabs for 2-tab files
vim.cmd[[
	autocmd FileType javascript.jsx,javascriptreact,vim,html,php setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
	autocmd FileType jscss,css,son,javascript,typescript,typescriptreact setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
]]
