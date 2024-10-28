--
-- Returns a trimmed string. Default is to trim whitespace.
--
-- PARAM: String s, the string to trim.
-- PARAM: char, nil or optional character to trim.
--
-- CREDIT: FreeBSD: Refactor makesyscalls.lua #1362
--
local function trim(s, char)
	if s == nil then
		return nil
	end
	if char == nil then
		char = "%s"
	end
	return s:gsub("^" .. char .. "+", ""):gsub(char .. "+$", "")
end

-- Returns a table (list) of strings.
-- CREDIT: FreeBSD: Refactor makesyscalls.lua #1362
local function split(s, re)
	local t = { }

	for v in s:gmatch(re) do
		table.insert(t, v)
	end
	return t
end

function CamelToSnake()
	local buf = vim.api.nvim_get_current_buf
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	-- camelCase only, NOT PascalCase too.
	local pattern = "([%l%d]+([%u])"

	for idx, line in ipairs(lines) do
		local new_line = line:gsub(pattern, function(lower, upper)
			return lower .. "_" .. upper:lower()
		end)
		lines[idx] = new_line
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

function SnakeToCamel()
	local buf = vim.api.nvim_get_current_buf
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local pattern = "([%l%d]+)_([%l%d]+)"

	for idx, line in ipairs(lines) do
		local new_line = line:gsub(pattern, function(before, after)
			return before .. after:upper()
		end)
		lines[idx] = new_line
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

function MakeDoxygenHeader(desc)
    local buf = vim.api.nvim_get_current_buf()
    local fh = vim.api.nvim_buf_get_name(buf)
    -- Determine the file extension
    local ext = filename:match("^.+%.(.+)$")  -- Extract the extension
    local date = os.date("%Y-%m-%d")
    local user = os.getenv("USER") or os.getenv("USERNAME") or "Your Name"
	local d = desc

	-- Set description based on the file extension.
    if ext == "cpp" or ext == "cxx" or ext == "cc" then
        d = desc or filename:match("([^/]+)%.cpp$") or "Class implementation."
		if d ~= desc then
        	desc = desc:gsub("^(%l)", string.upper) -- Convert to PascalCase
			desc = desc .. " implementation."
		end
    elseif ext == "h" or ext == "hpp" or ext == "hh" then
        d = desc or filename:match("([^/]+)%.%w+$") or "Header file"
		if d ~= desc then
        	desc = desc .. " header."
		end
    else
        desc = "Class implementation."  -- Default for other file types.
    end

    -- Create a Doxygen header string.
    local header = string.format([[
/**
 * @file %s
 *
 * %s
 *
 * @date %s
 * @author %s
 */
]], fh, desc, date, user)

    -- Split the header into lines
    local header_lines = vim.split(header, "\n")
    -- Get the current lines in the buffer
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    -- Calculate the new starting index based on the header length
    local start_line = 0
    -- Insert the header at the beginning
    vim.api.nvim_buf_set_lines(buf, start_line, start_line, false, header_lines)
    -- If you want to append the existing content after the header
    vim.api.nvim_buf_set_lines(buf, start_line + #header_lines, start_line + #header_lines, false, lines)
end

--
-- Private driver classes.
--

local generator = {}
generator.__index = generator

-- Wrapper for Lua write() best practice, for a simpler write call.
-- CREDIT: FreeBSD: Refactor makesyscalls.lua #1362
function generator:write(line)
	assert(self.gen:write(line))
end
