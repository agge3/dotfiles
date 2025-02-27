local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local config = require("config")
local keys = require("keys")
local monitor = require("monitor")
local util = require("util")
local logger = require("logger")
local settings = require("settings")

local rules = {}

-- Additional rulesets
rules.apps = require("rules.apps")
rules.general = require("rules.general")
rules.workspaces = require("rules.workspaces")
rules.games = require("rules.games")

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            -- screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            maximized = false,
            titlebars_enabled = beautiful.titlebars_enabled,
            maximized_horizontal = false,
            maximized_vertical = false,
            placement = floating_client_placement
        },
    },
}

-- Load in all the additional rulesets into the main rules table.
for _, v in ipairs(rules.apps) do
	table.insert(awful.rules.rules, v)
end
for _, v in ipairs(rules.general) do
	table.insert(awful.rules.rules, v)
end
for _, v in ipairs(rules.workspaces) do
	table.insert(awful.rules.rules, v)
end
for _, v in ipairs(rules.games) do
	table.insert(awful.rules.rules, v)
end

return rules
