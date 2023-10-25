local wezterm = require("wezterm")

local config = {}

-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 14
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 0,
}
config.front_end = "WebGpu"

return config
