--
-- Public interface to call script and make CXX implementation file stubs from
-- a currently opened CXX header file NeoVim buffer.
--
function MakeImpl()
	local impl = make_impl:new({})
	impl:parseHeader()
	impl:generateImpl()
end

--
-- Private utility functions.
--

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

--
-- Private driver classes.
--

local generator = {}
generator.__index = generator

-- Wrapper for Lua write() best practice. For a simpler write call.
-- CREDIT: FreeBSD: Refactor makesyscalls.lua #1362
function generator:write(line)
	assert(self.gen:write(line))
end

function generator:doxygenHeader(desc)
    local date = os.date("%Y-%m-%d")
	local user = os.getenv("USER") or os.getenv("USERNAME") or "Your Name" 

    gen:write(string.format([[
/**
 * @file %s
 *
 * This file contains the implementation of the class methods
 * defined in %s.
 *
 * @date %s
 * @author %s
 */

]], filename, desc or "Class implementation", filename, date, user))
end

-- generator binds to the parameter file.
-- CREDIT: FreeBSD: Refactor makesyscalls.lua #1362
function generator:new(obj, fh)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self

	self.gen = assert(io.open(fh, "w+"))

	return obj
end

local make_impl = {}
make_impl.__index = make_impl

function make_impl:init()
	self.buf = vim.api.nvim_get_current_buf
	self.fh = vim.api.nvim_buf_get_name(buf)
	self.fh = fh:match("(.+)%..+$") .. ".h"
	self.impl_fh = fh:gsub("%.h$", ".cpp")
end

function make_impl:processLine(line, key)
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
	table.insert(self.decl[key], {
		ret = words[1 + ret_offset],
		func = words[2 + func_offset],
	})
end

function make_impl:parseHeader()
	-- Parse file until we reach the `class` keyword.
	local lines = vim.api.nvim_buf_get_lines(self.buf, 0, -1, false)

	local copying = false
	local key = ""
	local template_decl = ""
	-- XXX Handle multi-line declarations.
	local found_scolon = false
	local multi_line = ""
	for num, line in ipairs(lines) do
		local trimmed = trim(line)

        -- Detect template declarations.
        if trimmed:find("^template%s*<") then
            template_decl = trimmed 	-- Store template declaration.
            goto next
        end

		if trimmed:find("^class") or trimmed:find("^struct") then
			copying = true
			local l = split(line)
			key = l[2]
			-- Add this class name as a key in our declarations table.
			self.decl[key] = {}
			if template_decl ~= "" then
				table.insert(self.decl[key], {
					template = template_decl
				})
			end
			-- Reset template declaration (if there was one), because each
			-- class/struct has its own template declaration (or lack thereof).
			template_decl = ""
			goto next	-- Go to next line.
		end
		if trimmed:find("};") then
			copying = false
			key = ""
			goto next	-- Go to next line.
		end
		if copying and line ~= "" then
			if line:find(";") == nil then
				found_scolon = true
			end
			if found_scolon and multi_line == "" then
				processLine(line, decl, key)
				multi_line = ""
			elseif found_scolon and multi_line ~= "" then	
				processLine(line, decl, key)
				multi_line = ""
			elseif not found_scolon then
				multi_line = multi_line .. line
			end
		end
		::next::
	end
end

function make_impl:processRetStatement(ret)
	local ret_statement = ""
	local found_ptr = ret:find("*")
	local found_strarr = ret:find("**")

	if ret:find("void") ~= nil and found_ptr ~= nil then
		-- do nothing
		ret_statement = ""
	-- This `find()` also handles special int types, like uint32_t, etc.
	elseif ret:find("int") ~= nil and found_ptr == nil then
		ret_statement = "return 0;"
	elseif ret:find("optional<") ~= nil and found_ptr == nil then
		ret_statement = "return std::nullopt;"
	elseif ret:find("float") ~= nil and found_ptr == nil then
		ret_statement = "return 0.f;"
	elseif ret:find("double") ~= nil and found_ptr == nil then
		ret_statement = "return 0.0;"
	elseif ret:find("bool") ~= nil and found_ptr == nil then
		ret_statement = "return false;"
	elseif ret:find("string") ~= nil and found_ptr == nil then
		ret_statement = "return \"\";"
	elseif found_ptr ~= nil and found_strarr == nil then
		ret_statement = "return nullptr"
	end

	return ret_statement
end

function make_impl:generateImpl(decl)
	-- XXX Find pwd -> `../` -> find src/source/etc. dir pattern -> create .cpp
	-- in dir, or create .cpp in `.` if failed.
	local gen = generator:new({}, self.impl_fh)

	-- Write out Doxygen-style file header.
	gen:doxygenHeader()

	-- Write out include for the header we just processed.
	gen:write(string.format("#include \"%s\"\n\n"))

	for k, v in pairs(self.decl) do
		for _, fn in pairs(v) do
			local r = processRetStatement(fn.ret)
			local f = strip(fn.func, ";")
			if fn.template ~= nil then
				gen:write(string.format("%s\n"), fn.template)
			end
			-- xxx handle class definition
			gen:write(string.format([[
%s %s::%s
{
	%s
}

]]), fn.ret, k, fn.func, r)
		end
	end
end

function make_impl:new(obj)
	obj = obj or {}
	setmetatable(obj, self)
	self.__index = self

	self.decl = {}

	self:init()
end
