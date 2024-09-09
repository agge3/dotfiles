-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menu = require("menu")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Jit
--pcall(function() jit.on() end)

-- Initialization

-- Features
-- Initialize icons array and load icon theme
--local icons = require("icons")
--icons.init(icon_theme)
-- Keybinds and mousebinds
local keys = require("keys")
-- Load notification daemons and notification theme
local notifications = require("notifications")
notifications.init(notification_theme)
-- Load window decoration theme and custom decorations
local decorations = require("decorations")
decorations.init(decoration_theme)

-- >> Elements - Desktop components
-- Statusbar(s)
--require("elemental.bar."..bar_theme)
---- Exit screen
--require("elemental.exit_screen."..exit_screen_theme)
---- Sidebar
--require("elemental.sidebar."..sidebar_theme)
---- Dashboard (previously called: Start screen)
--require("elemental.dashboard."..dashboard_theme)
---- Lock screen
---- Make sure to install lua-pam as described in the README or configure your
---- custom password in the 'user' section above
--local lock_screen = require("elemental.lock_screen")
--lock_screen.init()
---- App drawer
--require("elemental.app_drawer")
---- Window switcher
--require("elemental.window_switcher")
---- Toggle-able microphone overlay
--require("elemental.microphone_overlay")

-- >> Daemons
-- Most widgets that display system/external info depend on evil.
-- Make sure to initialize it last in order to allow all widgets to connect to
-- their needed evil signals.
--require("evil")
-- ===================================================================
-- ===================================================================

-- Garbage collection
-- Enable for lower memory consumption
-- ===================================================================
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
