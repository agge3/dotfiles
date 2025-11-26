local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local config = require("config")

local startup = {}

---- Set default layout for all tags.
--for s = 1, screen.count() do
--    tags[s] = awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, config.layout)
--end

-- Load theme.
local theme = config.theme
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/"
beautiful.init(theme_dir .. "theme.lua")

return startup
