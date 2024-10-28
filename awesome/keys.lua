local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require("apps")
local decorations = require("decorations")
local config = require("config")
local helpers = require("helpers")
local menu = require("menu")
local xrandr = require("xrandr")

local keys = {}

-- Mod keys
command = "Mod4"
option = "Mod1"
ctrl = "Control"
shift = "Shift"

-- Mouse bindings on desktop
keys.desktopbuttons = gears.table.join(
    awful.button({ }, 1, function ()
        -- Single tap
        naughty.destroy_all_notifications()
        -- Double tap
        local function double_tap()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end
        helpers.single_double_tap(function() end, double_tap)
    end),

    -- Right click
    -- awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 3, function ()
		menu.main_menu:toggle()
    end),

    -- Middle button
    awful.button({ }, 2, function ()
		-- xxx
    end),

    -- Scrolling - switch tags.
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),

    -- Side buttons - control volume.
    awful.button({ }, 9, function () helpers.volume_control(5) end),
    awful.button({ }, 8, function () helpers.volume_control(-5) end)
)

-- Key bindings:
keys.globalkeys = gears.table.join(
    -- Layouts:
	-- Max layout
    -- Single tap: Set max layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ command, option, ctrl }, "w",
        function()
            awful.layout.set(awful.layout.suit.max)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end)
        end,
        {description = "set max layout", group = "tag"}),

    -- Tiling
    -- Single tap: Set tiled layout
    -- Double tap: Also disable floating for ALL visible clients in the tag
    awful.key({ command, option, ctrl }, "s",
        function()
            awful.layout.set(awful.layout.suit.tile)
            helpers.single_double_tap(
                nil,
                function()
                    local clients = awful.screen.focused().clients
                    for _, c in pairs(clients) do
                        c.floating = false
                    end
                end)
        end,
        {description = "set tiled layout", group = "tag"}),

    -- Focus client by direction (hjkl keys).
    awful.key({ command }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ command }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ command }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ command }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),

    -- Focus client by direction (arrow keys).
    awful.key({ command }, "Down",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus down", group = "client"}),
    awful.key({ command }, "Up",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus up", group = "client"}),
    awful.key({ command }, "Left",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus left", group = "client"}),
    awful.key({ command }, "Right",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus right", group = "client"}),

    -- Focus client by index (cycle through clients). Only if fullscreen.
    awful.key({ command, option }, "Right",
		function() 
			if helpers.is_fullscreen_client_on_tag() then
            	awful.client.focus.byidx(1)
			end
		end,
        {description = "focus next by index", group = "client"}),

    awful.key({ command, option }, "Left",
		function() 
			if helpers.is_fullscreen_client_on_tag() then
            	awful.client.focus.byidx(-1)
			end
		end,
        {description = "focus next by index", group = "client"}),

    -- Resize focused client or layout factor.
    awful.key({ command, ctrl }, "Down", function (c)
        helpers.resize_dwim(client.focus, "down")
    end),
    awful.key({ command, ctrl }, "Up", function (c)
        helpers.resize_dwim(client.focus, "up")
    end),
    awful.key({ command, ctrl }, "Left", function (c)
        helpers.resize_dwim(client.focus, "left")
    end),
    awful.key({ command, ctrl }, "Right", function (c)
        helpers.resize_dwim(client.focus, "right")
    end),
    awful.key({ command, ctrl }, "j", function (c)
        helpers.resize_dwim(client.focus, "down")
    end),
    awful.key({ command, ctrl }, "k", function (c)
        helpers.resize_dwim(client.focus, "up")
    end),
    awful.key({ command, ctrl }, "h", function (c)
        helpers.resize_dwim(client.focus, "left")
    end),
    awful.key({ command, ctrl }, "l", function (c)
        helpers.resize_dwim(client.focus, "right")
    end),

    -- Number of master clients.
    awful.key({ command, option, ctrl }, "h",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ command, option, ctrl }, "l",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ command, option, ctrl }, "Left",   
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of master clients", group = "layout"}),
    awful.key({ command, option, ctrl }, "Right",   
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of master clients", group = "layout"}),

    -- Number of columns.
    awful.key({ command, option, ctrl }, "k",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ command, option, ctrl }, "j",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),
    awful.key({ command, option, ctrl }, "Up",   
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({ command, option, ctrl }, "Down",   
        function () 
            awful.tag.incncol( -1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}),

    -- Increase/decrease gaps.
    awful.key({ command }, "equals",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ command }, "minus",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),

    -- Brightness:
    awful.key({ }, "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell("light -U 10")
        end,
        {description = "decrease brightness", group = "brightness"}),
    awful.key({ }, "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell("light -A 10")
        end,
        {description = "increase brightness", group = "brightness"}),

    -- Volume control with volume keys:
    awful.key({ }, "XF86AudioMute",
        function()
            helpers.volume_control(0)
        end,
        {description = "(un)mute volume", group = "volume"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function()
            helpers.volume_control(-5)
        end,
        {description = "lower volume", group = "volume"}),
    awful.key({ }, "XF86AudioRaiseVolume",
        function()
            helpers.volume_control(5)
        end,
        {description = "raise volume", group = "volume"}),

    -- Mute microphone:
    awful.key({ }, "XF86AudioMicMute",
        function()
            awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        end,
        {description = "(un)mute microphone", group = "volume"}),

    -- Close client:
    awful.key({ command, }, "q", 
		function () 
			local c = client.focus
			if c then
				c:kill() 
			end
		end,
        {description = "close", group = "client"}),
    awful.key({ option }, "F4", 
		function () 
			local c = client.focus
			if c then
				c:kill() 
			end
		end,
        {description = "close", group = "client"}),
    -- Kill all visible clients for the current tag.
    awful.key({ command, option }, "q",
        function ()
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                c:kill()
            end
        end,
        {description = "kill all visible clients for the current tag", group = "gaps"}
    ),

    -- Reload Awesome:
    awful.key({ command, option, ctrl }, "r", 
		awesome.restart,
        {description = "reload awesome", group = "awesome"}),

    -- Quit Awesome:
    awful.key({ }, "XF86PowerOff",
        function ()
			aweful.spawn.easy_async_with_shell(
				"loginctl kill-session $(loginctl | grep tty1 | awk '{print $1}')"
			)
        end,
        {description = "quit awesome", group = "awesome"}),

    -- Screenshots:
    awful.key( { }, "Print", function() apps.screenshot("full") end,
        {description = "take full screenshot", group = "screenshots"}),
    awful.key( { command, shift }, "c", function() apps.screenshot("selection") end,
        {description = "select area to capture", group = "screenshots"}),
    awful.key( { command, ctrl }, "c", function() apps.screenshot("clipboard") end,
        {description = "select area to copy to clipboard", group = "screenshots"}),
    awful.key( { command }, "Print", function() apps.screenshot("browse") end,
        {description = "browse screenshots", group = "screenshots"}),
    awful.key( { command, shift }, "Print", function() apps.screenshot("gimp") end,
        {description = "edit most recent screenshot with gimp", group = "screenshots"}),

    -- Media keys:
    --awful.key({ command }, "F7", function() awful.spawn.with_shell("freeze firefox") end,
    --    {description = "send STOP signal to all firefox processes", group = "other"}),
    --awful.key({ command, shift }, "F7", function() awful.spawn.with_shell("freeze -u firefox") end,
    --    {description = "send CONT signal to all firefox processes", group = "other"}),
    --awful.key({ command }, "q", function() apps.scratchpad() end,
    --    {description = "scratchpad", group = "launcher"}),
	
    -- Urgent or undo:
    -- Jump to urgent client or (if there is no such client) go back
    -- to the last tag.
	-- xxx no bind
    awful.key({}, "",
        function ()
            uc = awful.client.urgent.get()
            -- If there is no urgent client, go back to last tag.
            if uc == nil then
                awful.tag.history.restore()
            else
                awful.client.urgent.jumpto()
            end
        end,
        {description = "jump to urgent client", group = "client"}),
	-- xxx no bind
    awful.key({}, "",
        function ()
            awful.tag.history.restore()
        end,
        {description = "go back", group = "tag"}),

    -- Window switcher:
    awful.key({ command }, "Tab",
        function ()
            window_switcher_show(awful.screen.focused())
        end,
        {description = "activate window switcher", group = "client"}),

    -- Menubar
    --awful.key({ command, ctrl }, "b", function() menubar.show() end,
    --{description = "show the menubar", group = "launcher"}),

    -- Run menu:
    awful.key({ command }, "r",
        function()
            awful.spawn.with_shell(
				"~/.config/rofi/launchers/type-7/launcher.sh"
			)
        end,
        {description = "rofi launcher", group = "launcher"}),

    -- Spawn terminal:
    awful.key({ command }, "Return", 
		function () 
			awful.spawn(config.user.terminal) 
		end,
        {description = "open a terminal", group = "launcher"}),

    -- Spawn floating terminal:
    awful.key({ command, shift }, "Return", 
		function()
        	awful.spawn(config.floating_terminal, {floating = true})
        end,
        {description = "spawn floating terminal", group = "launcher"}),

	-- Spawn ssh server terminal:
	awful.key({ command, option }, "Return", 
		function()
			awful.spawn(
				"/home/agge/.config/hypr/hyprland/scripts/kitty-ssh-server.sh"
			)
		end,
		{ description = "open a ssh server terminal", group = "launcher" }),

    -- Set floating layout:
    awful.key({ command, shift }, "s", function()
        awful.layout.set(awful.layout.suit.floating)
                                           end,
        {description = "set floating layout", group = "tag"}),

	---- Spawn applications
	-- Web-browser:
    awful.key({ command }, "w", apps.browser,
        {description = "web browser", group = "launcher"}),
	
    -- Spawn file manager:
    awful.key({ command }, "e", apps.file_manager,
        {description = "file manager", group = "launcher"}),

    -- Toggle wibar(s).
    awful.key({ command }, "b", function() wibars_toggle() end,
        {description = "show or hide wibar(s)", group = "awesome"}),

    -- Editor:
    awful.key({ command }, "e", apps.editor,
        {description = "editor", group = "launcher"}),

    -- Rofi youtube search and playlist selector.
    awful.key({ command }, "y", apps.youtube,
        {description = "youtube search and play", group = "launcher"}),

    -- Spawn file manager.
    awful.key({ command, shift }, "f", apps.file_manager,
        {description = "file manager", group = "launcher"}),

	-- Choose monitor config.
	awful.key({ command, option, ctrl }, "m",
		function()
			xrandr.xrandr()
		end,
		{ description = "monitor config", group = "awesome"}),

	-- Cycle through tags. If NOT fullscreen.
    awful.key({ command, option }, "Left", 
		function() 
			if not helpers.is_fullscreen_client_on_tag() then
				awful.tag.viewnext() 
			end
		end,
        {description = "focus previous tag", group = "client"}),
    awful.key({ command, option }, "Right", 
		function() 
			if not helpers.is_fullscreen_client_on_tag() then
				awful.tag.viewprev() 
			end
		end,
        {description = "focus next tag", group = "client"})
)

keys.clientkeys = gears.table.join(
    -- Move to edge or swap by direction
    awful.key({ command, shift }, "Down", function (c)
        helpers.move_client_dwim(c, "down")
    end),
    awful.key({ command, shift }, "Up", function (c)
        helpers.move_client_dwim(c, "up")
    end),
    awful.key({ command, shift }, "Left", function (c)
        helpers.move_client_dwim(c, "left")
    end),
    awful.key({ command, shift }, "Right", function (c)
        helpers.move_client_dwim(c, "right")
    end),
    awful.key({ command, shift }, "j", function (c)
        helpers.move_client_dwim(c, "down")
    end),
    awful.key({ command, shift }, "k", function (c)
        helpers.move_client_dwim(c, "up")
    end),
    awful.key({ command, shift }, "h", function (c)
        helpers.move_client_dwim(c, "left")
    end),
    awful.key({ command, shift }, "l", function (c)
        helpers.move_client_dwim(c, "right")
    end),

    -- Single tap: Center client 
    -- Double tap: Center client + Floating + Resize
    awful.key({ command }, "c", function (c)
        awful.placement.centered(c, {honor_workarea = true, honor_padding = true})
        helpers.single_double_tap(
            nil,
            function ()
                helpers.float_and_resize(c, screen_width * 0.65, screen_height * 0.9)
            end)
    end),

    -- Relative move client.
    awful.key({ command, shift, ctrl }, "j", function (c)
        c:relative_move(0,  dpi(20), 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "k", function (c)
        c:relative_move(0, dpi(-20), 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "h", function (c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "l", function (c)
        c:relative_move(dpi( 20), 0, 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "Down", function (c)
        c:relative_move(0,  dpi(20), 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "Up", function (c)
        c:relative_move(0, dpi(-20), 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "Left", function (c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end),
    awful.key({ command, shift, ctrl }, "Right", function (c)
        c:relative_move(dpi( 20), 0, 0, 0)
    end),

    -- Toggle titlebars (for focused client only).
    awful.key({ command,           }, "t",
        function (c)
            decorations.cycle(c)
        end,
        {description = "toggle titlebar", group = "client"}),
    -- Toggle titlebars (for all visible clients in selected tag).
    awful.key({ command, shift }, "t",
        function (c)
            local clients = awful.screen.focused().clients
            for _, c in pairs(clients) do
                decorations.cycle(c)
            end
        end,
        {description = "toggle titlebar", group = "client"}),

    -- Toggle fullscreen.
    awful.key({ command, }, "z",
		function ()
			helpers.toggle_fullscreen_on_tag()
        end,
    	{description = "toggle fullscreen", group = "client"}),

    ---- F for focused view
    --awful.key({ command, ctrl  }, "f",
    --    function (c)
    --        helpers.float_and_resize(c, screen_width * 0.7, screen_height * 0.75)
    --    end,
    --    {description = "focus mode", group = "client"}),
    ---- V for vertical view
    --awful.key({ command, ctrl  }, "v",
    --    function (c)
    --        helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.90)
    --    end,
    --    {description = "focus mode", group = "client"}),
    ---- T for tiny window
    --awful.key({ command, ctrl  }, "t",
    --    function (c)
    --        helpers.float_and_resize(c, screen_width * 0.3, screen_height * 0.35)
    --    end,
    --    {description = "tiny mode", group = "client"}),
    ---- N for normal size (good for terminals)
    --awful.key({ command, ctrl  }, "n",
    --    function (c)
    --        helpers.float_and_resize(c, screen_width * 0.45, screen_height * 0.5)
    --    end,
    --    {description = "normal mode", group = "client"}),

    -- Toggle floating
    awful.key({ command, }, "x",
        function(c)
            local layout_is_floating = (awful.layout.get(mouse.screen) == awful.layout.suit.floating)
            if not layout_is_floating then
                awful.client.floating.toggle()
            end
        end,
        {description = "toggle floating", group = "client"}),

    -- Set master
    awful.key({ command, ctrl }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),

	-- Change client opacity:
    awful.key({ ctrl, command }, "o",
        function (c)
            c.opacity = c.opacity - 0.1
        end,
        {description = "decrease client opacity", group = "client"}),
    awful.key({ command, shift }, "o",
        function (c)
            c.opacity = c.opacity + 0.1
        end,
        {description = "increase client opacity", group = "client"}),

    -- Keep on top:
    awful.key({ command, }, "v", 
		function (c) 
			c.ontop = not c.ontop 
		end,
        {description = "toggle keep on top", group = "client"}),
    -- Sticky:
    awful.key({ command, option }, "v", 
		function (c) 
			c.sticky = not c.sticky 
		end,
        {description = "toggle sticky", group = "client"}),

    -- Minimize:
    awful.key({ command, option }, "x",
        function (c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
    -- Maximize:
    awful.key({ command, option }, "z",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
            end
        end,
        {description = "restore minimized", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local ntags = 10
for i = 1, ntags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ command }, "#" .. i + 9,
            function ()
                -- Tag back and forth
                helpers.tag_back_and_forth(i)

                -- Simple tag view
                -- local tag = mouse.screen.tags[i]
                -- if tag then
                -- tag:view_only()
                -- end
            end,
            {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ command, ctrl }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ command, shift }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}),

        -- Move all visible clients to tag and focus that tag
        awful.key({ command, option }, "#" .. i + 9,
            function ()
                local tag = client.focus.screen.tags[i]
                local clients = awful.screen.focused().clients
                if tag then
                    for _, c in pairs(clients) do
                        c:move_to_tag(tag)
                    end
                    tag:view_only()
                end
            end,
            {description = "move all visible clients to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ command, ctrl, shift }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Mouse buttons on the client (whole window, not just titlebar)
keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c end),
    awful.button({ command }, 1, awful.mouse.client.move),
    -- awful.button({ command }, 2, function (c) c:kill() end),
    awful.button({ command }, 3, function(c)
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end),

    -- Super + scroll = Change client opacity
    awful.button({ command }, 4, function(c)
        c.opacity = c.opacity + 0.1
    end),
    awful.button({ command }, 5, function(c)
        c.opacity = c.opacity - 0.1
    end)
)

-- Mouse buttons on the tasklist
-- Use 'Any' modifier so that the same buttons can be used in the floating
-- tasklist displayed by the window switcher while the command is pressed
keys.tasklist_buttons = gears.table.join(
    awful.button({ 'Any' }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
            end
    end),
    -- Middle mouse button closes the window (on release)
    awful.button({ 'Any' }, 2, nil, function (c) c:kill() end),
    awful.button({ 'Any' }, 3, function (c) c.minimized = true end),
    awful.button({ 'Any' }, 4, function ()
        awful.client.focus.byidx(-1)
    end),
    awful.button({ 'Any' }, 5, function ()
        awful.client.focus.byidx(1)
    end),

    -- Side button up - toggle floating
    awful.button({ 'Any' }, 9, function(c)
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ 'Any' }, 8, function(c)
        c.ontop = not c.ontop
    end)
)

-- Mouse buttons on a tag of the taglist widget
keys.taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t)
        -- t:view_only()
        helpers.tag_back_and_forth(t.index)
    end),
    awful.button({ command }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    -- awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ }, 3, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ command }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end)
)

-- Mouse buttons on the primary titlebar of the window
keys.titlebar_buttons = gears.table.join(
    -- Left button - move
    -- (Double tap - Toggle maximize) -- A little BUGGY
    awful.button({ }, 1, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.move(c)
        -- local function single_tap()
        --   awful.mouse.client.move(c)
        -- end
        -- local function double_tap()
        --   gears.timer.delayed_call(function()
        --       c.maximized = not c.maximized
        --   end)
        -- end
        -- helpers.single_double_tap(single_tap, double_tap)
        -- helpers.single_double_tap(nil, double_tap)
    end),
    -- Middle button - close
    awful.button({ }, 2, function ()
        local c = mouse.object_under_pointer()
        c:kill()
    end),
    -- Right button - resize
    awful.button({ }, 3, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        awful.mouse.client.resize(c)
        -- awful.mouse.resize(c, nil, {jump_to_corner=true})
    end),
    -- Side button up - toggle floating
    awful.button({ }, 9, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        --awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        c.floating = not c.floating
    end),
    -- Side button down - toggle ontop
    awful.button({ }, 8, function()
        local c = mouse.object_under_pointer()
        client.focus = c
        c.ontop = not c.ontop
        -- Double Tap - toggle sticky
        -- local function single_tap()
        --   c.ontop = not c.ontop
        -- end
        -- local function double_tap()
        --   c.sticky = not c.sticky
        -- end
        -- helpers.single_double_tap(single_tap, double_tap)
    end)
)

-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
