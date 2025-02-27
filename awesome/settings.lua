local monitor = require("monitor")
local util = require("util")
local logger = require("logger")

local settings = {}

logger:log("Available settings:")

-- Window sizes determined from:
-- https://learn.microsoft.com/en-us/windows/apps/design/layout/screen-sizes-and-breakpoints-for-responsive-design 
settings.small_window = {
	{ width = 320, height = 569 },
	{ width = 360, height = 640 },
	{ width = 480, height = 854 },
}

settings.medium_window = {
	{ width = 960, height = 540 },
}

settings.large_window = {
	{ width = 1024, height = 640 },
	{ width = 1366, height = 768 },
}

settings.sq_window = {
	{ width = 360, 			height = 360 		}, -- 1
	{ width = 360 * 1.25, 	height = 360 * 1.25 }, -- 2
	{ width = 360 * 1.5, 	height = 360 * 1.5 	}, -- 3
	{ width = 360 * 1.75, 	height = 360 * 1.75	}, -- 4
	{ width = 360 * 2, 		height = 360 * 2 	}, -- 5
	{ width = 360 * 2.25, 	height = 360 * 2.25 }, -- 6
	{ width = 360 * 2.5, 	height = 360 * 2.5 	}, -- 7
	{ width = 360 * 3, 		height = 360 * 3 	}, -- 8
	{ width = 360 * 3.5, 	height = 360 * 3.5 	}, -- 9
	{ width = 360 * 4, 		height = 360 * 4 	}, -- 10
}

settings.vert_rect_window = {
	{ width = 240, 			height = 360 		}, -- 1
	{ width = 240 * 1.25, 	height = 360 * 1.25 }, -- 2
	{ width = 240 * 1.5, 	height = 360 * 1.5 	}, -- 3
	{ width = 240 * 1.75, 	height = 360 * 1.75	}, -- 4
	{ width = 240 * 2, 		height = 360 * 2 	}, -- 5
	{ width = 240 * 2.25, 	height = 360 * 2.25 }, -- 6
	{ width = 240 * 2.5, 	height = 360 * 2.5 	}, -- 7
	{ width = 240 * 3, 		height = 360 * 3 	}, -- 8
	{ width = 240 * 3.5, 	height = 360 * 3.5 	}, -- 9
	{ width = 240 * 4, 		height = 360 * 4 	}, -- 10
}

settings.hori_rect_window = {
	{ width = 360, 			height = 240 		}, -- 1
	{ width = 360 * 1.25, 	height = 240 * 1.25 }, -- 2
	{ width = 360 * 1.5, 	height = 240 * 1.5 	}, -- 3
	{ width = 360 * 1.75, 	height = 240 * 1.75	}, -- 4
	{ width = 360 * 2, 		height = 240 * 2 	}, -- 5
	{ width = 360 * 2.25, 	height = 240 * 2.25 }, -- 6
	{ width = 360 * 2.5, 	height = 240 * 2.5 	}, -- 7
	{ width = 360 * 3, 		height = 240 * 3 	}, -- 8
	{ width = 360 * 3.5, 	height = 240 * 3.5 	}, -- 9
	{ width = 360 * 4, 		height = 240 * 4 	}, -- 10
}

-- Application preset window size settings.
settings.pavucontrol = 7

-- Initialize width and height to be assigned for each preset.
local width, height

-- xxx needs to be more clear, but looks nice
-- Aspect ratio is maintained when multiplying by monitor, so "ignore" 
-- maintaining aspect ratio.
width, height = util.width_ignore_aspect_ratio(0.25, "16:9")
settings.small_aspect = {
	width = width * monitor.width,
	height = height * monitor.height
}

width, height = util.width_ignore_aspect_ratio(0.5, "16:9")
settings.medium_aspect = {
	width = width * monitor.width,
	height = height * monitor.height
}

width, height = util.width_ignore_aspect_ratio(0.7, "16:9")
settings.large_aspect = {
	width = width * monitor.width,
	height = height * monitor.height
}

-- xxx needs to be more clear, but looks nice
-- Have to "maintain" aspect ratio to "ignore" aspect ratio when multiplying by
-- monitor.
height, width = util.width_aspect_ratio(0.25, "16:9")
settings.small_sq = {
	width = width * monitor.width,
	height = height * monitor.height
}

height, width = util.width_aspect_ratio(0.5, "16:9")
settings.medium_sq = {
	width = width * monitor.width,
	height = height * monitor.height
}

height, width = util.width_aspect_ratio(0.7, "16:9")
settings.large_sq = {
	width = width * monitor.width,
	height = height * monitor.height
}

-- Done with these, don't hang onto their values.
width, height = nil

function settings.log()
	logger:log("Available settings:")
	
	logger:log("small_aspect: width = " .. settings.small_aspect.width ..
			", height = " .. settings.small_aspect.height)
	logger:log("medium_aspect: width = " .. settings.medium_aspect.width ..
			", height = " .. settings.medium_aspect.height)
	logger:log("large_aspect: width = " .. settings.large_aspect.width ..
			", height = " .. settings.large_aspect.height)
	
	logger:log("small_sq: width = " .. settings.small_sq.width .. 
			", height = " .. settings.small_sq.height)
	logger:log("medium_sq: width = " .. settings.medium_sq.width ..
			", height = " .. settings.medium_sq.height)
	logger:log("large_sq: width = " .. settings.large_sq.width ..
			", height = " .. settings.large_sq.height)
end

return settings
