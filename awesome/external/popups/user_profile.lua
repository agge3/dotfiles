-- xxx port everything that calls this to call config instead
local user_profile = {
	name = "agge",
	image_path = os.getenv("HOME") .. "/.config/awesome/external.popups.control_center/assets/Untitled.png",
	dnd_status = false,
	browser = 'firefox ',
	file_manager = 'thunar ',
	terminal = 'kitty',
	icon_theme_path = "/.icons/Papirus/32x32/apps/",
	--wallpaper = os.getenv("HOME") .. '/.config/awesome/Wallpapers/catMachup.jpg',
	--fallback_password = "1234",
}

return user_profile
