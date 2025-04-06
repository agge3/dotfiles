local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local config = require("config")
local logger = require("logger")
local taskbar = require("taskbar")

local monitor = {}

logger:log("Monitor resolutions:")

local pwidth = screen.primary.geometry.width
local pheight = screen.primary.geometry.height
logger:log("Primary monitor: width = " .. pwidth .. ", height = " .. pheight)

-- Wallpaper
--local function set_wallpaper(s)
----    -- Wallpaper
--	if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen.
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
----
--        -- >> Method 1: Built in wallpaper function
--        gears.wallpaper.fit(wallpaper, s, true)
--        gears.wallpaper.maximized(wallpaper, s, true)
----
----        -- >> Method 2: Set theme's wallpaper with feh
----        --awful.spawn.with_shell("feh --bg-fill " .. wallpaper)
----
----        -- >> Method 3: Set last wallpaper with feh
----        --awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
--    end
--end

local function set_wallpaper(s)
	--local wallpaper = "/home/agge/.config/wallpaper/wallhaven-2yodx9.png"
	--local wallpaper = "/home/agge/wallpaper/amd-minimal-logo-3840x2160-10739.png"
	local wallpaper = "/home/agge/.config/wallpaper/wallhaven-kw96z7.png"
	gears.wallpaper.maximized(wallpaper, s)
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    --set_wallpaper(s)
	local tb = taskbar:new({}, s)
end)

local function test_set_wallpaper(s)
	local w = '/home/agge/.config/wallpaper/wWNnXKb.jpeg'
	gears.wallpaper.maximized(wallpaper, s)
end
--test_set_wallpaper(nil)
--screen[1]	-- center
--screen[2]	-- left
--screen[3] -- right


--screen[1]	-- center
--screen[2]	-- left
--screen[3] -- right

screen[1].id = 'DP-2'
screen[2].id = 'DP-0'
screen[3].id = 'HDMI-A-0'

--gears.timer {
--	timeout = 1800,
--	autostart = true,
--	callback = function()
--		for s in screen do
--			s:emit_signal('request::wallpaper')
--		end
--	end,
--}

for s in screen do
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

-- Each screen has its own tag table.
local l = awful.layout.suit -- Alias to save time :)
-- Tag layouts
local layouts = {
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair,
    l.fair
}

-- Tag names
local tagnames = beautiful.tagnames or config.workspace_tags
-- Create all tags at once (without seperate configuration for each tag)
--awful.tag(tagnames, s, layouts)

-- Create tags with seperate configuration for each tag
awful.tag.add(tagnames[1], {
    layout = layouts[1],
    screen = screen[1],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[2], {
    layout = layouts[1],
    screen = screen[1],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[3], {
    layout = layouts[1],
    screen = screen[1],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[4], {
    layout = layouts[1],
    screen = screen[1],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[5], {
    layout = layouts[1],
    screen = screen[1],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[6], {
    layout = layouts[1],
    screen = screen[2],
    master_width_factor = 0.6,
    selected = true,
})
awful.tag.add(tagnames[7], {
    layout = layouts[1],
    screen = screen[3],
    master_width_factor = 0.6,
    selected = true,
})


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- xxx nil?
--awful.screen.connect_signal("property::geometry", set_wallpaper)

-------------------------------------------------------------------------------

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

-- Get screen geometry.
monitor.curr_width = awful.screen.focused().geometry.width
monitor.curr_height = awful.screen.focused().geometry.height

monitor.pref_width = pwidth
monitor.pref_height = pheight

-- xxx to not break old calls
monitor.width = pwidth
monitor.height = pheight

return monitor
