require("bufferline").setup({
    highlights = require("catppuccin.special.bufferline").get_theme(),
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
