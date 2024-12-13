local wezterm = require 'wezterm'

local config = {}

config.color_scheme = 'Catppuccin Macchiato'
config.font_size = 16
config.font = 
    wezterm.font('JetBrainsMono Nerd Font', {weight = 'Bold', italic = false})

config.hide_tab_bar_if_only_one_tab = true
config.hide_mouse_cursor_when_typing = true
config.default_cursor_style = 'SteadyUnderline'
-- config.window_decorations = 'RESIZE'

config.keys = {
    { key = 'n', mods = 'CMD', action = wezterm.action.SpawnCommandInNewWindow { cwd=wezterm.home_dir } },
}

config.initial_cols = 100
config.initial_rows = 30

return config
