local beautysh = require ('efmls-configs.formatters.beautysh')
local fs = require('efmls-configs.fs')
local shfmt = require('efmls-configs.formatters.shfmt')

local languages = {
  sh = { shfmt },
  zsh = { beautysh },
}

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

require('lspconfig').efm.setup(efmls_config)
