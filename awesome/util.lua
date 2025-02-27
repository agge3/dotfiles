local gears = require("gears")
--local awful = require("awful")
--local wibox = require("wibox")
--local beautiful = require("beautiful")
--local xresources = require("beautiful.xresources")
--local naughty = require("naughty")
--local helpers = require("helpers")
--local config = require("config")
--local error = require("error")
--local signals = require("signals")
--local screen = require("screen")
--local rules = require("rules")
--local keys = require("keys")
--local menu = require("menu")
--local wibox = require("wibox")
--local apps = require("apps")
--local decorations = require("decorations")
--local icons = require("icons")
--local notifications = require("notifications")

local util = {}

-- Given a height (e.g., 1080) and an aspect ratio (default: "16:9"), returns a
-- pair of the correct width, height for the aspect ratio.
function util.height_aspect_ratio(height, ratio)
	ratio = ratio or "16:9"
	local w_ratio, h_ratio = ratio:match("(%d+):(%d+)")
	local r = w_ratio / h_ratio
	return height * r, height
end

-- Given a width (e.g., 1920) and an aspect ratio (default: "16:9"), returns a
-- pair of the correct width, height for the aspect ratio.
function util.width_aspect_ratio(width, ratio)
	ratio = ratio or "16:9"
	local w_ratio, h_ratio = ratio:match("(%d+):(%d+)")
	local r = h_ratio / w_ratio
	return width, width * r
end

-- Given a height (e.g., 1080) and an aspect ratio (default: "16:9"), returns a
-- pair of the correct width, height to ignore the aspect ratio.
function util.height_ignore_aspect_ratio(height, ratio)
	return height, height
end

-- Given a width (e.g., 1920) and an aspect ratio (default: "16:9"), returns a
-- pair of the correct width, height to ignore the aspect ratio.
function util.width_ignore_aspect_ratio(width, ratio)
	return width, width
end

-- Convert a decimal opacity (out of 1.0) to a hexadecimal opacity postfix.
function util.opacity_to_hex(opacity)
    -- Ensure the opacity value is clamped between 0 and 1.
    opacity = math.max(0, math.min(1, opacity))
    
    -- Scale the opacity to 255 and round to the nearest integer.
    local value = math.floor(opacity * 255 + 0.5)
    
    -- Convert to a two-character hexadecimal string.
    return string.format('%02X', value)
end

-- Returns the current working directory on *nix systems.
function util.cwd()
    local handle = io.popen("pwd")
    local cwd = handle:read("*l")
    handle:close()
    return cwd
end

-- Call the garbage collector for AwesomeWM, with a specified time for the 
-- timeout or every 30 seconds if not provided.
function util.garbage_collector(time)
	time = time or 30
	gears.timer {
		timeout = time,
		autostart = true,
		callback = function() collectgarbage() end
	}
end

return util
