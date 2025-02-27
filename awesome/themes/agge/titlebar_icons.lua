local logger = require("logger")

return function(theme, path)
	local titlebar_icons_path = path .. "/assets/titlebar_icons/"
	logger:log("Titlebar icons path: " .. titlebar_icons_path)

	-- Close Button
	theme.titlebar_close_button_normal                    = titlebar_icons_path .. "inactive.png"
	theme.titlebar_close_button_focus                     = titlebar_icons_path .. "close.png"
	theme.titlebar_close_button_normal_hover              = titlebar_icons_path .. "close_hover.png"
	theme.titlebar_close_button_focus_hover               = titlebar_icons_path .. "close_hover.png"
	
	-- Maximized Button
	theme.titlebar_maximized_button_normal_inactive       = titlebar_icons_path .. "inactive.png"
	theme.titlebar_maximized_button_focus_inactive        = titlebar_icons_path .. "maximize.png"
	theme.titlebar_maximized_button_normal_active         = titlebar_icons_path .. "inactive.png"
	theme.titlebar_maximized_button_focus_active          = titlebar_icons_path .. "maximize.png"
	theme.titlebar_maximized_button_normal_inactive_hover = titlebar_icons_path .. "maximize-hover.png"
	theme.titlebar_maximized_button_focus_inactive_hover  = titlebar_icons_path .. "maximize-hover.png"
	theme.titlebar_maximized_button_normal_active_hover   = titlebar_icons_path .. "maximize-hover.png"
	theme.titlebar_maximized_button_focus_active_hover    = titlebar_icons_path .. "maximize-hover.png"
	
	-- Minimize Button
	theme.titlebar_minimize_button_normal                 = titlebar_icons_path .. "inactive.png"
	theme.titlebar_minimize_button_focus                  = titlebar_icons_path .. "minimize.png"
	theme.titlebar_minimize_button_normal_hover           = titlebar_icons_path .. "minimize_hover.png"
	theme.titlebar_minimize_button_focus_hover            = titlebar_icons_path .. "minimize_hover.png"
	
	-- Sticky Button
	theme.titlebar_sticky_button_normal_inactive = titlebar_icons_path .. "inactive.png"
	theme.titlebar_sticky_button_focus_inactive  = titlebar_icons_path .. "pin.png"
	theme.titlebar_sticky_button_normal_active   = titlebar_icons_path .. "inactive.png"
	theme.titlebar_sticky_button_focus_active    = titlebar_icons_path .. "pin2.png"
end
