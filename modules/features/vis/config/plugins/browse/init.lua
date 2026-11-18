local module = {}
local lf_backend = {
	command = 'lf -print-selection',
	command_format = '%s %s',
}

-- TODO: introduce abstraction over this
module.tui_backend = lf_backend
module.pwd_track = nil
module.pwd = os.getenv('PWD')

local open_func = function()
	local pwd = module.pwd

	if module.pwd_track ~= nil then
		pwd = module.pwd_track:get_pwd()
	end

	local command = string.format(
		module.tui_backend.command_format,
		module.tui_backend.command,
		pwd
	)
	local file = io.popen(command)

	local output = {}
	for line in file:lines() do
		table.insert(output, line)
	end

	local success, msg, status = file:close()

	if status == 0 and #output >= 1 then
		vis:feedkeys(string.format(':e "%s"<Enter>', output[1]))
	elseif status ~= 0 then
		vis:info(string.format('browse: Unknown exit status %d: %s', status, msg))
	end

	vis:feedkeys('<vis-redraw>')
	return true;
end

vis:map(vis.modes.NORMAL, ' t', open_func, 'Select file to open with external terminal application')

return module
