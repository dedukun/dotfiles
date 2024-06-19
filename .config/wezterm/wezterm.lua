local wezterm = require("wezterm")

local config = {}

-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = false
config.font = wezterm.font("JetBrainsMono NFM")
config.font_size = 14
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.90
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 0,
}
config.front_end = "WebGpu"
config.disable_default_key_bindings = true
config.check_for_updates = false
config.keys = {
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "C",
		mods = "CTRL",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "V",
		mods = "CTRL",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "L",
		mods = "CTRL",
		action = wezterm.action.ShowDebugOverlay,
	},
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "E",
		mods = "CTRL",
		action = wezterm.action.ActivateCopyMode,
	},
}

return config
