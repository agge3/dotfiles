local wezterm = require('wezterm')
local action = wezterm.action

local config = wezterm.config_builder()

config.enable_wayland = true

-- no login shell
config.default_prog = { '/bin/zsh' }

config.font = wezterm.font('Hack Nerd Font')
config.font_size = 12.0
config.dpi = 192.0

config.color_scheme = 'current-theme'
config.window_background_opacity = 0.82

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.tab_max_width = 64

-- Keybinds
config.keys = {
	{
		key = 'q',
		mods = 'CTRL|SHIFT',
		-- xxx maybe confirm?
		action = action.CloseCurrentTab {confirm = false},
	},
	{
		key = 'LeftArrow',
		mods = 'CTRL|SHIFT',
		action = action.ActivateTabRelative(-1),
	},
	{
		key = 'RightArrow',
		mods = 'CTRL|SHIFT',
		action = action.ActivateTabRelative(1),
	}
}

return config
