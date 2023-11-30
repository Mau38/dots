local ok, nordic = pcall(require, "nordic")
if not ok then 
  return
end
nordic.setup()

local ok, feline = pcall(require, "feline")
if not ok then
	return
end
feline.setup()

local ok, icons  = pcall(require, "nvim-web-devicons")
if not ok then
	return
end
icons.setup()

local ok, fox  = pcall(require, "nightfox")
if not ok then
	return
end
vim.cmd[[colorscheme carbonfox]]

local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end
gitsigns.setup()

local ok, colorizer = pcall(require, "colorizer")
if not ok then
  return
end
colorizer.setup()

nordic.load()
