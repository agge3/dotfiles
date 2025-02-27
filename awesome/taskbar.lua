local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local config = require("config")

local taskbar = {}

function taskbar:init(s)
	---- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
	                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
	                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
	                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
	                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
	    screen  = s,
	    filter  = awful.widget.taglist.filter.all,
	    buttons = taglist_buttons
	}
	
	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
	    screen  = s,
	    filter  = awful.widget.tasklist.filter.currenttags,
	    buttons = tasklist_buttons
	}
	
	---- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })
	
	-- Add widgets to the wibox
	s.mywibox:setup {
	    layout = wibox.layout.align.horizontal,
	    { -- Left widgets
	        layout = wibox.layout.fixed.horizontal,
	        mylauncher,
	        s.mytaglist,
	        s.mypromptbox,
	    },
	    s.mytasklist, -- Middle widget
	    { -- Right widgets
	        layout = wibox.layout.fixed.horizontal,
	        mykeyboardlayout,
	        wibox.widget.systray(),
	        mytextclock,
	        s.mylayoutbox,
	    },
	}
end

function taskbar:topbar(s)
	-- Custom Local Library: Common Functional Decoration
	local color = require("external.topbar.colors")
	
	--Spacer
	local separator = wibox.widget.textbox("     ")

	--textclock widget
	mytextclock = wibox.widget.textclock(
		'<span color="' .. color.white .. '" font="Ubuntu Nerd Font Bold 13"> %a %b %d, %H:%M </span>', 10)
	
	--calendar-widget
	--xxx
	--local cw = calendar_widget({
	--	theme = "nord",
	--	placement = "top_center",
	--	start_sunday = true,
	--	radius = 8,
	--	previous_month_button = 1,
	--	padding = 5,
	--	next_month_button = 3,
	--})
	--mytextclock:connect_signal("button::press", function(_, _, _, button)
	--	if button == 1 then
	--		cw.toggle()
	--	end
	--end)
	
	--Fancy taglist widget
	awful.screen.connect_for_each_screen(function(s)
		local fancy_taglist = require("fancy_taglist")
		mytaglist = fancy_taglist.new({
			screen   = s,
			taglist  = { buttons = taglist_buttons },
			tasklist = { buttons = tasklist_buttons },
			filter   = awful.widget.taglist.filter.all,
			style    = {
				shape = gears.shape.rounded_rect
			},
		})
	end)
	
	--Taglist widget
	local fancy_taglist = wibox.widget {
		{
			mytaglist,
			widget = wibox.container.background,
			shape  = gears.shape.rounded_rect,
			bg     = color.background_lighter
		},
		left   = dpi(3),
		right  = dpi(3),
		top    = dpi(3),
		bottom = dpi(3),
		widget = wibox.container.margin
	
	}
	
	local awesome_logo = require("external.topbar.awesome_logo")
	--local top_left = require("external.topbar.top_left")
	local systray = require("external.topbar.systray")
	
	local mywibox =
		awful.wibar({
			position = "top",
			-- margins = { top = dpi(7), left = dpi(8), right = dpi(8), bottom = 0 },
			margins = { top = dpi(0), left = dpi(0), right = dpi(0), bottom = 0 },
			screen = s,
			height = dpi(35),
			opacity = 1,
			fg = color.blueish_white,
			bg = "#00000000",
			-- shape = function(cr, width, height)
			--   -- gears.shape.rounded_rect(cr, width, height, 8)
			--   gears.shape.rounded_rect(cr, width, height, 0)
			-- end,
	
		})
	
	--Main Wibar
	mywibox:setup {
		{
			layout = wibox.layout.stack,
			expand = "none",
			{
				layout = wibox.layout.align.horizontal,
				{
					-- Left widgets
					layout = wibox.layout.fixed.horizontal,
					separator,
					awesome_logo,
					separator,
					fancy_taglist,
					separator,
				},
				nil,
				{
					-- Right widgets
					layout = wibox.layout.fixed.horizontal,
					systray,
					separator,
					top_left,
					separator,
					-- xxx
					--batteryarc_widget({
					--	show_current_level = true,
					--	arc_thickness = 3,
					--	size = 26,
					--	font = "CaskaydiaCove Nerd Font 10",
					--	margins = 55,
					--	timeout = 10,
					--}),
	
					separator,
				},
			},
			{
				mytextclock,
				valign = "center",
				halign = "center",
				layout = wibox.container.place,
			}
		},
		widget = wibox.container.background,
		bg = color.background_dark,
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 0)
			-- gears.shape.rounded_rect(cr, width, height, 0)
		end,
	
	}
end

function taskbar:new(obj, screen)
    obj = obj or { }
    setmetatable(obj, self)
    self.__index = self

	self:topbar(screen)

    return obj
end

return taskbar
