local config = {}

local themes = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "ephemeral",    -- 4 --
    "amarena",      -- 5 --
	"agge",			-- 6 --
}
-- Change this number to use a different theme.
config.theme = themes[6]

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

local layouts = {
	"awful.layout.suit.corner.nw",	-- 1 -- Corner layout.
	"awful.layout.suit.corner.ne",	-- 2 -- Corner layout.
	"awful.layout.suit.corner.sw",	-- 3 -- Corner layout.
	"awful.layout.suit.corner.se",	-- 4 -- Corner layout.
	"awful.layout.suit.",			-- 5 -- The floating layout.
	"awful.layout.suit.magnifier",	-- 6 -- The magnifier layout.
	"awful.layout.suit.max.name",	-- 7 -- Maximized layout.
	"awful.layout.suit.max.fullscreen",	-- 8 -- Fullscreen layout.
	"awful.layout.suit.spiral.dwindle",	-- 9 -- Dwindle layout.
	"awful.layout.suit.spiral.name",	-- 10 -- Spiral layout.
	"awful.layout.suit.tile.right", -- 11 -- The main tile algo, on the right.
	"awful.layout.suit.tile.left", -- 12 -- The main tile algo, on the left.
	"awful.layout.suit.tile.bottom", -- 13 -- The main tile algo, on the bottom.
	"awful.layout.suit.tile.top", -- 14 -- The main tile algo, on the top.
}
config.layout = layouts[9]

-- User variables and preferences
config.user = {
    -- >> Default applications <<
    -- Check apps.lua for more
    terminal = "kitty -1",
    floating_terminal = "kitty -1",
    browser = "firefox",
    file_manager = "thunar",
    editor = "kitty -1 --class editor -e nvim",
    email_client = "kitty -1 --class email -e neomutt",

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
