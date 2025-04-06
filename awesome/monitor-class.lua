config = require("config")

awful = require("awful")

local monitor = {}

monitor.__index = monitor

-- SEE: `xrandr --listmonitors`.
screen[1].id = 'DP-2'
screen[2].id = 'DP-0'
screen[3].id = 'HDMI-A-0'

local function set_wallpaper(s)
	logger:log("monitor:\tscreen.id:\t" .. s.id)
	logger:log("monitor:\twallpaper path:\t" .. config.wallpapers[s.id])

	local surf = gears.surface.load_uncached(config.wallpapers[s.id])
	-- xxx use gears.debug.print_error(message)
	if surf == nil then
		logger:log("monitor:\tError loading wallpaper surface:\t" .. 
			config.wallpapers[s.id])
	else
		logger:log("monitor:\tLoaded wallpaper surface:\t" ..
			config.wallpapers[s.id])
	end

	awful.wallpaper {
		screen = s,
		widget = {
			image = gears.surface.crop_surface {
				surface = surf,
				ratio = s.geometry.width / s.geometry.height,
			},
			widget = wibox.widget.imagebox,
		},
	}
end

-- We want a workspace layout, so we treat tags as workspaces.
local function set_workspaces()

end

function monitor:init()
	for s in screen do
		set_wallpaper(s)
	end
end

--
-- EXTERNAL
-- CREDIT: XXX
--

-- Determines how floating clients should be placed
local floating_client_placement = function(c)
    -- If the layout is floating or there are no other visible
    -- clients, center client
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
        return awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
    end

    -- Else use this placement
    local p = awful.placement.no_overlap + awful.placement.no_offscreen
    return p(c, {honor_padding = true, honor_workarea=true, margins = beautiful.useless_gap * 2})
end

local centered_client_placement = function(c)
    return gears.timer.delayed_call(function ()
        awful.placement.centered(c, {honor_padding = true, honor_workarea=true})
    end)
end

function monitor:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self

	return obj
end
