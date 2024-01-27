local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("jdtls not found")
  return
end

local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/lsp_server/jdtls"

local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/workplace/java"

local root_markers = { 'gradelw', 'mvnw', '.git' }

function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

local on_attach = function(client, bufnr)


local SYSTEM = "linux"
if vim.fn.has "mac" == 1 then

end
