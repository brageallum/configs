local options = {
  smartindent = true,
  incsearch = true,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  number = true,
  relativenumber = true,
  cursorline = true,
  scrolloff = 8,
  sidescrolloff = 8,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  nobackup = true,
  noswapfile = true,
  mouse = "a",
  splitbelow = true,
  splitright = true,
  autoread = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

