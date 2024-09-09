local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local naughty = require("naughty")
local util = require("util")
local helpers = require("helpers")
local error = require("error")
local signals = require("signals")
local screen = require("screen")
local rules = require("rules")
local keys = require("keys")
local menu = require("menu")
local wibox = require("wibox")
local apps = require("apps")
local decorations = require("decorations")
local icons = require("icons")
local notifications = require("notifications")

local config = {}

local themes = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "ephemeral",    -- 4 --
    "amarena",      -- 5 --
}
-- Change this number to use a different theme
config.theme = themes[5]

-- Affects the window appearance: titlebar, titlebar buttons...
local decoration_themes = {
    "lovelace",       -- 1 -- Standard titlebar with 3 buttons (close, max, min)
    "skyfall",        -- 2 -- No buttons, only title
    "ephemeral",      -- 3 -- Text-generated titlebar buttons
}
config.decoration_theme = decoration_themes[3]

-- Statusbar themes. Multiple bars can be declared in each theme.
local bar_themes = {
    "manta",        -- 1 -- Taglist, client counter, date, time, layout
    "lovelace",     -- 2 -- Start button, taglist, layout
    "skyfall",      -- 3 -- Weather, taglist, window buttons, pop-up tray
    "ephemeral",    -- 4 -- Taglist, start button, tasklist, and more buttons
    "amarena",      -- 5 -- Minimal taglist and dock with autohide
}
config.bar_theme = bar_themes[5]

-- Affects which icon theme will be used by widgets that display image icons.
local icon_themes = {
    "linebit",        -- 1 -- Neon + outline
    "drops",          -- 2 -- Pastel + filled
}
config.icon_theme = icon_themes[2]

local notification_themes = {
    "lovelace",       -- 1 -- Plain with standard image icons
    "ephemeral",      -- 2 -- Outlined text icons and a rainbow stripe
    "amarena",        -- 3 -- Filled text icons on the right, text on the left
}
config.notification_theme = notification_themes[3]

local sidebar_themes = {
    "lovelace",       -- 1 -- Uses image icons
    "amarena",        -- 2 -- Text-only (consumes less RAM)
}
config.sidebar_theme = sidebar_themes[2]

local dashboard_themes = {
    "skyfall",        -- 1 --
    "amarena",        -- 2 -- Displays coronavirus stats
}
config.dashboard_theme = dashboard_themes[2]

local exit_screen_themes = {
    "lovelace",      -- 1 -- Uses image icons
    "ephemeral",     -- 2 -- Uses text-generated icons (consumes less RAM)
}
config.exit_screen_theme = exit_screen_themes[2]

config.workspace_tags = { "一", "二", "三", "四", "五", "六", "七", "八", "九" }

config.wallpaper = {
	"~/.config/wallpaper/wallhaven-2yodx9.png",
	"~/.config/wallpaper/wallhaven-kw96z7.png",
	"~/.config/wWNnXKB.jpeg",
}

-- User variables and preferences
config.user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    file_manager = "kitty -1 --class files -e ranger",
    editor = "kitty -1 --class editor -e vim",
    email_client = "kitty -1 --class email -e neomutt",
    music_client = "kitty -o font_size=12 --class music -e ncmpcpp",

    -- >> Web Search <<
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "xdg-open https://www.google.com/search?q=",

    -- >> User profile <<
    profile_picture = os.getenv("HOME").."/.config/awesome/profile.png",

    -- Directories with fallback values
    dirs = {
        downloads = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        documents = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        music = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pictures = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        videos = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        -- Make sure the directory exists so that your screenshots
        -- are not lost
        screenshots = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },

    -- >> Sidebar <<
    sidebar = {
        hide_on_mouse_leave = true,
        show_on_mouse_screen_edge = true,
    },

    -- >> Lock screen <<
    -- This password will ONLY be used if you have not installed
    -- https://github.com/RMTT/lua-pam
    -- as described in the README instructions
    -- Leave it empty in order to unlock with just the Enter key.
    lock_screen_custom_password = "",

    -- >> Battery <<
    -- You will receive notifications when your battery reaches these
    -- levels.
    --battery_threshold_low = 20,
    --battery_threshold_critical = 5,

	-- xxx 
    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    --openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    --openweathermap_city_id = "yyyyyy",
    ---- > Use "metric" for Celcius, "imperial" for Fahrenheit
    --weather_units = "imperial",
}

return config
