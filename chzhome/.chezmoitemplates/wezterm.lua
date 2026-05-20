local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 100
config.initial_rows = 30
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.hide_tab_bar_if_only_one_tab = true
config.hide_mouse_cursor_when_typing = true
config.default_cursor_style = 'SteadyUnderline'
--config.window_decorations = 'RESIZE'
config.keys = {
    {
        key = 'n',
        mods = 'CMD',
        action = wezterm.action.SpawnCommandInNewWindow { cwd = wezterm.home_dir },
    },
}

return config
