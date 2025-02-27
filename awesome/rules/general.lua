local settings = require("settings")
local monitor = require("monitor")

return {
	-- Floating clients (auto).
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "floating_terminal",
                "riotclientux.exe",
                "leagueclientux.exe",
                "Devtools", -- Firefox devtools
            },
            class = {
                "Gpick",
                "Lxappearance",
                "Nm-connection-editor",
                "File-roller",
                "fst",
                "Nvidia-settings",
            },
            name = {
                "Event Tester",  -- xev
                "MetaMask Notification",
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileChooserDialog",
                "conversation",
            },
            type = {
                "dialog",
            }
        },
        properties = { floating = true }
    },

	-- Floating clients (small).
    {
        rule_any = {
			class = {
				--"pavucontrol",
			},
		},
        properties = {
			floating = true,
			width = settings.small_window[2].width,
			height = settings.small_window[2].height,
		},
    },

	-- Floating clients (medium).
    {
        rule_any = {
			class = {
				--"pavucontrol",
				"steam",
			},
		},
        properties = {
			floating = true,
			width = settings.medium_window[1].width,
			height = settings.medium_window[1].height,
		},
    },

	-- Floating clients (large).
    {
        rule_any = {
			class = {
				--"pavucontrol",
			},
		},
        properties = {
			floating = true,
			width = settings.large_window[1].width,
			height = settings.large_window[1].height,
		},
    },

    -- Centered clients
    {
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                "Steam",
                --"discord",
                "music",
                "markdown_input",
                "scratchpad",
            },
            instance = {
                "music",
                "markdown_input",
                "scratchpad",
            },
            role = {
                "GtkFileChooserDialog",
                "conversation",
            }
        },
        properties = { placement = centered_client_placement },
    },
    -- Titlebars OFF (explicitly)
    {
        rule_any = {
            instance = {
                "install league of legends (riot client live).exe",
                "gw2-64.exe",
                "battle.net.exe",
                "riotclientservices.exe",
                "leagueclientux.exe",
                "riotclientux.exe",
                "leagueclient.exe",
                "^editor$",
                "markdown_input"
            },
            class = {
                "qutebrowser",
                "Sublime_text",
                "Subl3",
                --"discord",
                --"TelegramDesktop",
                "firefox",
                "Nightly",
                "Steam",
                "Lutris",
                "Chromium",
                "^editor$",
                "markdown_input"
                -- "Thunderbird",
            },
            type = {
              "splash"
            },
            name = {
                "^discord.com is sharing your screen.$" -- Discord (running in browser) screen sharing popup
            }
        },
        callback = function(c)
            decorations.hide(c)
        end
    },

    -- Titlebars ON (explicitly)
    {
        rule_any = {
            type = {
                "dialog",
            },
            role = {
                "conversation",
            }
        },
        callback = function(c)
            decorations.show(c)
        end
    },

    -- "Needy": Clients that steal focus when they are urgent
    {
        rule_any = {
            class = {
                "TelegramDesktop",
                "firefox",
                "Nightly",
            },
            type = {
                "dialog",
            },
        },
        callback = function (c)
            c:connect_signal("property::urgent", function ()
                if c.urgent then
                    c:jump_to()
                end
            end)
        end
    },
}
