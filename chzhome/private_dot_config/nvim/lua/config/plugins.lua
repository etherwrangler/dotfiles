vim.pack.add({
    { src = "https://github.com/akinsho/bufferline.nvim", name = "bufferline.nvim" },
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons", name = "mini.icons" },
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
})

require("catppuccin").setup({
    integrations = {
        snacks = true,
    },
})
vim.cmd.colorscheme("catppuccin-mocha")

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("plugins.bufferline")
require("plugins.conform")
require("plugins.snacks")
