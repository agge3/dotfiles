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

local function captureChevron(words)
	local capturing = false
	local new_words = {}
	local s = ""
	for idx, word in ipairs(words) do 
		if word:find("<") ~= nil then
			capturing = true
			s = s .. word
		elseif word:find(">") ~= nil and capturing then
			s = s .. " " .. word
			table.insert(new_words, s)
			capturing = false
			s = ""
		elseif capturing then
			s = s .. " " .. word
		else
			table.insert(new_words, word)
		end
	end
	if s ~= "" then
		table.insert(new_words, s)
	end
	return new_words
end

local function captureParen(words)
	local capturing = false
	local new_words = {}
	local s = ""
	for idx, word in ipairs(words) do 
		if word:find("(") ~= nil then
			capturing = true
			s = s .. word
		elseif word:find(")") ~= nil and capturing then
			s = s .. " " .. word
			table.insert(new_words, s)
			capturing = false
			s = ""
		elseif capturing then
			s = s .. " " .. word
		else
			table.insert(new_words, word)
		end
	end
	if s ~= "" then
		table.insert(new_words, s)
	end
	return new_words
end

local function processLine(line, decl)
	words = split(line)
	-- XXX This is where the many ways something can be declared in CXX
	-- headers can cause a lot of variations. This handling is the most
	-- likely to cause issues.
	local ret_offset = 0
	local func_offset = 0
	words = captureChevron(words)
	words = captureParen(words)
	if words[1] == "const" then
		ret_offset = 1
		func_offset = 1
	else if words[2] == "const" then
		func_offset = 1
	end
	if words[#words] == "const" then
		local s = words[#words - 1] .. " " .. words[#words]
	end
	table.insert(decl, {
		ret = words[1 + ret_offset],
		func = words[2 + func_offset],
	})
end

local function MakeImpl()
	-- Parse file until we reach the `class` keyword.
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1 false)

	local copying = false
	local decl = {}
	-- XXX Handle multi-line declarations.
	local found_scolon = false
	local multi_line = ""
	for num, line in ipairs(lines) do
		local trimmed = trim(line)
		if trimmed:find("class") then
			copying = true
			local l = split(line)
			local key = l[2]
			-- Add this class name as a key in our declarations table.
			decl[key] = nil
			goto next	-- Go to next line.
		end
		if trimmed:find("};") then
			copying = false
			goto next	-- Go to next line.
		end
		if copying and line ~= "" then
			if line:find(";") == nil then
				found_scolon = true
			end
			if found_scolon and multi_line == "" then
				processLine(line, decl)
				multi_line = ""
			elseif not found_scolon then
				multi_line = multi_line .. line
			elseif found_scolon and multi_line ~= "" then	
				processLine(line, decl)
				multi_line = ""
			end
		end
		::next::
	end
end
