local settings = require("settings")
local monitor = require("monitor")

return {
	-- Fixed terminal geometry for floating terminals
    {
        rule_any = {
            class = {
                "Alacritty",
                "Termite",
                "mpvtube",
                "kitty",
                "st-256color",
                "st",
                "URxvt",
            },
        },
        properties = {
			width = monitor.width * 0.45,
			height = monitor.height * 0.5
		}
    },

	{
		rule_any = { class = { "pavucontrol" } },
		properties = {
			floating = true,
			width = 680,
			height = 725
		},
	},
	{
		rule_any = { class = { "discord" } },
		properties = {
			floating = true,
			width = 1245,
			height = 910
		},
	},
	{
		rule_any = { class = { "InputOutput" } },	-- Ark
		properties = {
			floating = true,
			width = 955,
			height = 685
		},
	},
	{
		rule_any = { class = { "InputOutput" } },	-- Kate
		properties = {
			floating = true,
			width = 945,
			height = 945
		},
	},

    -- File chooser dialog
    {
        rule_any = { role = { "GtkFileChooserDialog" } },
        properties = {
			floating = true,
			width = monitor.width * 0.55,
			height = monitor.height * 0.65
		}
    },

    -- LibreOffice dialog
    {
        rule_any = { role = { "InputOutput" } },
        properties = {
			floating = true,
			width = 720,
			height = 570,
			-- xxx pos
		}
    },

    -- Galculator
    {
        rule_any = { 
			class = { 
				"Galculator",
				"kcalc",
			}
		},
        except_any = { type = { "dialog" } },
        properties = {
			floating = true,
			width = 545,
			height = 420,
		},
    },

    -- File managers
    {
        rule_any = {
            class = {
                "Nemo",
                "Thunar"
            },
        },
        except_any = { type = { "dialog" } },
        properties = { 
			floating = true,
			width = monitor.width * 0.45,
			height = monitor.height * 0.55
		}
    },

    -- Screenruler
    {
        rule_any = { class = { "Screenruler" } },
        properties = { border_width = 0, floating = true, ontop = true, titlebars_enabled = false },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    -- Keepass
    {
        rule_any = { class = { "KeePassXC" } },
        except_any = { name = { "KeePassXC-Browser Confirm Access" }, type = { "dialog" } },
        properties = { floating = true, width = monitor.width * 0.7, height = monitor.height * 0.75},
    },

    -- Scratchpad
    {
        rule_any = {
            instance = {
                "scratchpad",
                "markdown_input"
            },
            class = {
                "scratchpad",
                "markdown_input"
            },
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = monitor.width * 0.7,
            height = monitor.height * 0.75
        }
    },

    -- Image viewers
    {
        rule_any = {
            class = {
                "feh",
                "Sxiv",
            },
        },
        properties = {
            floating = true,
            width = monitor.width * 0.7,
            height = monitor.height * 0.75
        },
        callback = function (c)
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        end
    },

    -- Dragon drag and drop utility
    {
        rule_any = {
            class = {
                "Dragon-drag-and-drop",
                "Dragon",
            },
        },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            width = monitor.width * 0.3,
        },
        callback = function (c)
            awful.placement.bottom_right(c, {
                honor_padding = true,
                honor_workarea = true,
                margins = { bottom = beautiful.useless_gap * 2, right = beautiful.useless_gap * 2}
            })
        end
    },

   	-- Chatting
    {
        rule_any = {
            class = {
                "Chromium",
                "Chromium-browser",
                --"discord",
                "TelegramDesktop",
                "Signal",
                "Slack",
                "TeamSpeak 3",
                "zoom",
                "weechat",
                "6cord",
            },
        },
        properties = { floating = true, width = monitor.width * 0.45, height = monitor.height * 0.8 }
    },

    -- Editing
    {
        rule_any = {
            class = {
                "^editor$",
                -- "Emacs",
                -- "Subl3",
            },
        },
    },

    -- System monitoring
    {
        rule_any = {
            class = {
                "htop",
            },
            instance = {
                "htop",
            },
        },
    },

    -- Image editing
    {
        rule_any = {
            class = {
                "Gimp",
                "Inkscape",
            },
        },
    },

    -- Mail
    {
        rule_any = {
            class = {
                "email",
            },
            instance = {
                "email",
            },
        },
    },

    -- Miscellaneous
    -- All clients that I want out of my way when they are running
    {
        rule_any = {
            class = {
                "torrent",
                "Transmission",
                "Deluge",
                "VirtualBox Manager",
                "KeePassXC"
            },
            instance = {
                "torrent",
                "qemu",
            }
        },
        except_any = {
            type = { "dialog" }
        },
    },

	-- Transmission
    {
        rule_any = {
            class = { "transmission-gtk" },
			type = { "dialog" },
        },
		properties = {
			floating = true,
			width = 920,
			height = 695,
		},
    },	


    -- TODO why does Chromium always start up floating in AwesomeWM?
    -- Temporary fix until I figure it out
    {
        rule_any = {
            class = {
                "Chromium-browser",
                "Chromium",
            }
        },
        properties = { floating = false }
    },

    -- -- Unfocusable clients (unless clicked with the mouse)
    -- -- If you want to prevent focusing even when clicking them, you need to
    -- -- modify the left click client mouse bind in keys.lua
    -- {
    --     rule_any = {
    --         class = {
    --             "scratchpad"
    --         },
    --     },
    --     properties = { focusable = false }
    -- },
}
