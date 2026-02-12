local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size = false,
    initial_cols = 100,
    initial_rows = 30,
    color_scheme = 'Catppuccin Macchiato',
    font_size = 16,
    font = wezterm.font('JetBrainsMono Nerd Font'),
    hide_tab_bar_if_only_one_tab = true,
    hide_mouse_cursor_when_typing = true,
    default_cursor_style = 'SteadyUnderline',
    --window_decorations = 'RESIZE',
    keys = {
        {
            key = 'n',
            mods = 'CMD',
            action = wezterm.action.SpawnCommandInNewWindow { cwd=wezterm.home_dir },
        },
    },
}
