local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local config = require("config")

local monitor = {}

-- Wallpaper
--local function set_wallpaper(s)
--    -- Wallpaper
--    if beautiful.wallpaper then
--        local wallpaper = beautiful.wallpaper
--        -- If wallpaper is a function, call it with the screen.
--        if type(wallpaper) == "function" then
--            wallpaper = wallpaper(s)
--        end
--
--        -- >> Method 1: Built in wallpaper function
--        gears.wallpaper.fit(wallpaper, s, true)
--        gears.wallpaper.maximized(wallpaper, s, true)
--
--        -- >> Method 2: Set theme's wallpaper with feh
--        --awful.spawn.with_shell("feh --bg-fill " .. wallpaper)
--
--        -- >> Method 3: Set last wallpaper with feh
--        --awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
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
    set_wallpaper(s)

    ---- Create a promptbox for each screen
    --s.mypromptbox = awful.widget.prompt()

    ---- Create an imagebox widget which will contain an icon indicating which layout we're using.
    ---- We need one layoutbox per screen.
    --s.mylayoutbox = awful.widget.layoutbox(s)
    --s.mylayoutbox:buttons(gears.table.join(
    --                       awful.button({ }, 1, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
    --                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
    --                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    ---- Create a taglist widget
    --s.mytaglist = awful.widget.taglist {
    --    screen  = s,
    --    filter  = awful.widget.taglist.filter.all,
    --    buttons = taglist_buttons
    --}

    ---- Create a tasklist widget
    --s.mytasklist = awful.widget.tasklist {
    --    screen  = s,
    --    filter  = awful.widget.tasklist.filter.currenttags,
    --    buttons = tasklist_buttons
    --}

    ---- Create the wibox
    --s.mywibox = awful.wibar({ position = "top", screen = s })

    ---- Add widgets to the wibox
    --s.mywibox:setup {
    --    layout = wibox.layout.align.horizontal,
    --    { -- Left widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        mylauncher,
    --        s.mytaglist,
    --        s.mypromptbox,
    --    },
    --    s.mytasklist, -- Middle widget
    --    { -- Right widgets
    --        layout = wibox.layout.fixed.horizontal,
    --        mykeyboardlayout,
    --        wibox.widget.systray(),
    --        mytextclock,
    --        s.mylayoutbox,
    --    },
    --}
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--awful.screen.connect_signal("property::geometry", set_wallpaper)

-------------------------------------------------------------------------------

-- Tags and layouts:
awful.screen.connect_for_each_screen(function(s)
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
    awful.tag(tagnames, s, layouts)

    -- Create tags with seperate configuration for each tag
    -- awful.tag.add(tagnames[1], {
    --     layout = layouts[1],
    --     screen = s,
    --     master_width_factor = 0.6,
    --     selected = true,
    -- })
    -- ...
end)

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
monitor.width = awful.screen.focused().geometry.width
monitor.height = awful.screen.focused().geometry.height

return monitor
