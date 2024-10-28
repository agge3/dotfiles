local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local config = require("config")
local wibox = require("wibox")
local menubar = require("menubar")

local menu = {}

local awesome_menu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", config.user.terminal .. " -e man awesome" },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

menu.main_menu = awful.menu({ items = { 
	{ "awesome", awesome_menu, beautiful.awesome_icon },
    { "terminal", config.user.terminal },
	{ "files", "dolphin"},
	{ "editor", "kate"},
	{ "firefox", "firefox"},
	{ "office", "libreoffice"},
	{ "calc", "kcalc"},
	{ "kvm", "virt-manager"},
}})

menu.launcher = awful.widget.launcher({ 
	image = beautiful.awesome_icon,
    menu = main_menu
})

-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = config.user.terminal

-- Keyboard map indicator and switcher
local keyboard_layout = awful.widget.keyboardlayout()

-- Wibar
-- Create a textclock widget
--local text_clock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
--local taglist_buttons = gears.table.join(
--	awful.button({ }, 1, function(t) t:view_only() end),
--    awful.button({ modkey }, 1, function(t)
--    	if client.focus then
--        	client.focus:move_to_tag(t)
--        end
--    end),
--
--    awful.button({ }, 3, awful.tag.viewtoggle),
--    awful.button({ modkey }, 3, function(t)
--	    if client.focus then
--	        client.focus:toggle_tag(t)
--	    end
--	end),
--
--    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
--    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end),
--)
--
--local tasklist_buttons = gears.table.join(
--	awful.button({ }, 1, function (c)
--	    if c == client.focus then
--	        c.minimized = true
--	    else
--	        c:emit_signal(
--	            "request::activate",
--	            "tasklist",
--	            {raise = true}
--	        )
--	    end
--	end),
--
--	awful.button({ }, 3, function()
--		awful.menu.client_list({ theme = { width = 250 } })
--	end),
--
--	awful.button({ }, 4, function ()
--	    awful.client.focus.byidx(1)
--	end),
--
--	awful.button({ }, 5, function ()
--		awful.client.focus.byidx(-1)
--	end),
--)

return menu
