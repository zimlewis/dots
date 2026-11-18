-- IT'S TV TIME!!!!!!
local M = {}
local tv = {
	live_grep_command = 'tv vis-text',
	find_file_command = 'tv vis-files',
}

M.pwd_track = nil
M.pwd = os.getenv('PWD')
M.tv = tv

local function join(...)
	return table.concat({...}, "/"):gsub("//+", "/")
end

function M:get_pwd()
	local pwd = self.pwd

	if self.pwd_track ~= nil then
		pwd = self.pwd_track:get_pwd()
	end

	return pwd
end

local execute = function(command)
	local file = io.popen(command)

	local outputs = {}
	for line in file:lines() do
		table.insert(outputs, line)
	end

	local success, msg, status = file:close()
	return outputs, success, msg, status
end

function M:find_file()
	local pwd = self:get_pwd()

	local command = self.tv.find_file_command..' '..pwd

	local outputs, success, msg, status = execute(command)
	if status == 0 and #outputs >= 1 then
		local file_path = join(pwd, outputs[1])
		vis:feedkeys(string.format(':e "%s"<Enter>', file_path))
	elseif status ~= 0 then
		vis:info(string.format('tv-time: Unknown exit status %d: %s', status, msg))
	end

	vis:feedkeys('<vis-redraw>')
	return true;
end

function M:live_grep()
	local pwd = self:get_pwd()

	local command = self.tv.live_grep_command..' '..pwd

	local outputs, success, msg, status = execute(command)
	if status == 0 and #outputs >= 1 then
		local file_path = join(pwd, outputs[1])
		vis:feedkeys(string.format(':e "%s"<Enter>', file_path))
	elseif status ~= 0 then
		vis:info(string.format('tv-time: Unknown exit status %d: %s', status, msg))
	end

	vis:feedkeys('<vis-redraw>')
	return true;
end

return M
