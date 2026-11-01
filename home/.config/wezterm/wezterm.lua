local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 17.0
config.window_background_opacity = 0.85
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- macOS-style text navigation
config.keys = {
	-- Cmd+Left / Cmd+Right: jump to start / end of line
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action.SendString("\x01") }, -- Ctrl+A
	{ key = "RightArrow", mods = "CMD", action = wezterm.action.SendString("\x05") }, -- Ctrl+E
	-- Cmd+Backspace: delete the line
	{ key = "Backspace", mods = "CMD", action = wezterm.action.SendString("\x15") }, -- Ctrl+U
	-- Option+Left / Option+Right: move by word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendString("\x1bb") },
	{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendString("\x1bf") },
}

return config
