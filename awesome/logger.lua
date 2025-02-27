local logger = {}

local log_dir = os.getenv("HOME") .. "/debug"
local log_file = log_dir .. "/awesomewmtest.log"

function logger:cleanup()
	os.remove(log_file)
end

function logger:log(s)
	self.fh:write(s .. "\n")
	self.fh:flush()
end

function logger:new(obj)
    obj = obj or { }
    setmetatable(obj, self)
    self.__index = self

    -- If logger already exists, don't create a new one, just return the
	-- existing one.
    if self.fh then
        return self
    end

	os.execute("mkdir -p " .. log_dir)
	self:cleanup()
	self.fh = assert(io.open(log_file, "a"), "Failed to open log file.")

    return obj
end

function logger:close()
	if self.fh then
		self.fh:close()
		self.fh = nil
	end
end

return logger
