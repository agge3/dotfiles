-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library.
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Notification library.
local naughty = require("naughty")

-- User-defined configuration.
local config = require("config")

-- Theme handling library.
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global.
dpi = beautiful.xresources.apply_dpi
-- Make xresources colors global.
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

-- Error handling and startup procedures.
local error = require("error")
local monitor = require("monitor")
local startup = require("startup")

-- Widget and layout library.
local wibox = require("wibox")

local menu = require("menu")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps when client with a matching 
-- name is opened:
require("awful.hotkeys_popup.keys")

local util = require("util")
local helpers = require("helpers")
local config = require("config")
local signals = require("signals")
local rules = require("rules")
local keys = require("keys")
local apps = require("apps")

-- Keybinds and mousebinds.
local keys = require("keys")

local notifications = require("notifications")
local decorations = require("decorations")

local xrandr = require("xrandr")

-- Jit
--pcall(function() jit.on() end)

-- Garbage collection
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
