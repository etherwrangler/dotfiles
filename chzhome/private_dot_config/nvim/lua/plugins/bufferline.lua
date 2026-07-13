local colors = require("catppuccin.palettes").get_palette()

require("bufferline").setup({
    highlights = require("catppuccin.special.bufferline").get_theme({
        custom = {
            all = {
                separator = { fg = colors.surface1 },
                separator_visible = { fg = colors.surface1 },
                separator_selected = { fg = colors.lavender },
            },
        },
    }),
    options = {
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        offsets = {
            {
                filetype = "snacks_picker_list",
                text = "Explorer",
                text_align = "center",
                separator = true,
            },
        },
    },
})
