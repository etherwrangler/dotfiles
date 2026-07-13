vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.filetypes")
require("config.plugins")
require("config.statusline").setup()
require("config.workspace").setup()
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
