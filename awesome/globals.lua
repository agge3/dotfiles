themes = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "ephemeral",    -- 4 --
    "amarena",      -- 5 --
}
-- Change this number to use a different theme
theme = themes[5]
-- ===================================================================
-- Affects the window appearance: titlebar, titlebar buttons...
decoration_themes = {
    "lovelace",       -- 1 -- Standard titlebar with 3 buttons (close, max, min)
    "skyfall",        -- 2 -- No buttons, only title
    "ephemeral",      -- 3 -- Text-generated titlebar buttons
}
decoration_theme = decoration_themes[3]
-- ===================================================================
-- Statusbar themes. Multiple bars can be declared in each theme.
bar_themes = {
    "manta",        -- 1 -- Taglist, client counter, date, time, layout
    "lovelace",     -- 2 -- Start button, taglist, layout
    "skyfall",      -- 3 -- Weather, taglist, window buttons, pop-up tray
    "ephemeral",    -- 4 -- Taglist, start button, tasklist, and more buttons
    "amarena",      -- 5 -- Minimal taglist and dock with autohide
}
bar_theme = bar_themes[5]

-- ===================================================================
-- Affects which icon theme will be used by widgets that display image icons.
icon_themes = {
    "linebit",        -- 1 -- Neon + outline
    "drops",          -- 2 -- Pastel + filled
}
icon_theme = icon_themes[2]
-- ===================================================================
notification_themes = {
    "lovelace",       -- 1 -- Plain with standard image icons
    "ephemeral",      -- 2 -- Outlined text icons and a rainbow stripe
    "amarena",        -- 3 -- Filled text icons on the right, text on the left
}
notification_theme = notification_themes[3]
-- ===================================================================
sidebar_themes = {
    "lovelace",       -- 1 -- Uses image icons
    "amarena",        -- 2 -- Text-only (consumes less RAM)
}
sidebar_theme = sidebar_themes[2]
-- ===================================================================
dashboard_themes = {
    "skyfall",        -- 1 --
    "amarena",        -- 2 -- Displays coronavirus stats
}
dashboard_theme = dashboard_themes[2]
-- ===================================================================
exit_screen_themes = {
    "lovelace",      -- 1 -- Uses image icons
    "ephemeral",     -- 2 -- Uses text-generated icons (consumes less RAM)
}
exit_screen_theme = exit_screen_themes[2]
