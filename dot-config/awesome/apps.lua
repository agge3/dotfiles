local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")
local icons = require("icons")
local notifications = require("notifications")
local config = require("config")
local scripts = require("scripts")

local apps = {}

-- xxx switchtotag
apps.editor = function ()
    helpers.run_or_raise({instance = 'editor'}, false, config.user.editor)
end
apps.browser = function ()
    awful.spawn(config.user.browser)
end
apps.file_manager = function ()
    awful.spawn(config.user.file_manager, { floating = true })
end
apps.telegram = function ()
    helpers.run_or_raise({class = 'TelegramDesktop'}, false, "telegram")
end
apps.mail = function ()
    helpers.run_or_raise({instance = 'email'}, false, config.user.email_client)
end
apps.gimp = function ()
    helpers.run_or_raise({class = 'Gimp'}, false, "gimp")
end
apps.steam = function ()
    helpers.run_or_raise({class = 'Steam'}, false, "steam")
end
apps.lutris = function ()
    helpers.run_or_raise({class = 'Lutris'}, false, "lutris")
end
apps.youtube = function ()
    awful.spawn.with_shell("rofi_mpvtube")
end
apps.passwords = function ()
    helpers.run_or_raise({class = 'KeePassXC'}, true, "keepassxc")
end
apps.volume = function ()
    helpers.run_or_raise({class = 'Pavucontrol'}, true, "pavucontrol")
end
apps.record = function ()
    awful.spawn.with_shell("screenrec.sh")
end

apps.discord = function ()
    -- Run or raise Discord running in the browser, spawned with Chromium browser's app mode
    -- >> Ubuntu / Debian
    -- helpers.run_or_raise({instance = 'discordapp.com__channels_@me'}, false, "chromium-browser --app=\"https://discordapp.com/channels/@me\"")
    -- >> Arch
    helpers.run_or_raise({instance = 'discordapp.com__channels_@me'}, false, "chromium --app=\"https://discordapp.com/channels/@me\"")

    -- Run or raise Discord app
    -- helpers.run_or_raise({class = 'discord'}, false, "discord")
end

-- Toggle compositor
apps.compositor = function ()
    awful.spawn.with_shell("sh -c 'pgrep picom > /dev/null && pkill picom || picom --experimental-backends --config ~/.config/picom/picom.conf & disown'")
end

local night_mode_notif
apps.night_mode = function ()
    local cmd = "pgrep redshift > /dev/null && (pkill redshift && echo 'OFF') || (echo 'ON' && redshift -l 0:0 -t 3700:3700 -r &>/dev/null &)"
    awful.spawn.easy_async_with_shell(cmd, function(out)
        local message = out:match('ON') and "Activated!" or "Deactivated!"
        night_mode_notif = notifications.notify_dwim({ title = "Night mode", message = message, app_name = "night_mode", icon = icons.image.redshift }, night_mode_notif)
    end)
end

local screenkey_notif
apps.screenkey = function ()
    local cmd = "pgrep screenkey > /dev/null && (pkill screenkey && echo 'OFF') || (echo 'ON' && screenkey --ignore Caps_Lock --bg-color '#FFFFFF' --font-color '#000000' &>/dev/null &)"
    awful.spawn.easy_async_with_shell(cmd, function(out)
        local message = out:match('ON') and "Activated!" or "Deactivated!"
        screenkey_notif = notifications.notify_dwim({ title = "Screenkey", message = message, app_name = "screenkey", icon = icons.image.keyboard }, screenkey_notif)
    end)
end

-- Screenshots:
local capture_notif = nil
local screenshot_notification_app_name = "screenshot"
function apps.screenshot(action, delay)
	scripts.screenshot.exec(action, delay)
end

return apps
