local wezterm = require 'wezterm'

local config = {}

-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 14.5
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.95

return config
