local awful = require("awful")

local settings = require("settings")
local monitor = require("monitor")

return {
    ---------------------------------------------
    -- Start application on specific workspace --
    ---------------------------------------------
    -- Browsing
    {
        rule_any = {
            class = {
                "firefox",
                "Nightly",
                -- "qutebrowser",
            },
        },
        except_any = {
            role = { "GtkFileChooserDialog" },
            instance = { "Toolkit" },
            type = { "dialog" }
        },
        properties = { },
    },

    -- Games
    {
        rule_any = {
            class = {
                "underlords",
                "lt-love",
                "portal2_linux",
                "deadcells",
                "csgo_linux64",
                "EtG.x86_64",
                "factorio",
                "dota2",
                "Terraria.bin.x86",
                "dontstarve_steam",
                "Wine",
                "trove.exe",
				"Bioshock"
            },
            instance = {
                "love.exe",
                "synthetik.exe",
                "pathofexile_x64steam.exe",
                "leagueclient.exe",
                "glyphclientapp.exe",
				"bioshock.exe"
            },
        },
		-- xxx always set games to 2k
        properties = {
			screen = 1, 
			tag = awful.screen.focused().tags[2] 
		},
    },
}
