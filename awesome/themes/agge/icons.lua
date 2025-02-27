local util = require("util")
local logger = require("logger")

return function(theme, path)
	local icons_path = path .. "/assets/icons/"
	logger:log("Icons path: " .. icons_path)

	theme.menu_submenu_icon = icons_path.."submenu.svg"
	
	-- You can use your own layout icons like this:
	--theme.layout_fairh = icons_path .. "fairh.png"
	--theme.layout_fairv = icons_path .. "fairv.png"
	--theme.layout_floating  = icons_path .. "floating.png"
	--theme.layout_magnifier = icons_path .. "magnifier.png"
	--theme.layout_max = icons_path .. "max.png"
	--theme.layout_fullscreen = icons_path .. "fullscreen.png"
	--theme.layout_tilebottom = icons_path .. "tilebottom.png"
	--theme.layout_tileleft   = icons_path .. "tileleft.png"
	--theme.layout_tile = icons_path .. "tile.png"
	--theme.layout_tiletop = icons_path .. "tiletop.png"
	--theme.layout_spiral  = icons_path .. "spiral.png"
	--theme.layout_dwindle = icons_path .. "dwindle.png"
	--theme.layout_cornernw = icons_path .. "cornernw.png"
	--theme.layout_cornerne = icons_path .. "cornerne.png"
	--theme.layout_cornersw = icons_path .. "cornersw.png"
	--theme.layout_cornerse = icons_path .. "cornerse.png"
end
