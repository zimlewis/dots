local module = {}

-- TODO: introduce abstraction over this
module.command = 'lf -print-selection'
module.command_format = '%s %s'
module.pwd = os.getenv('PWD')

local open_func = function()
	local command = string.format(module.command_format, module.command, module.pwd)
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

vis:map(vis.modes.NORMAL, " ff", open_func, 'Select file to open with external terminal application')
vis:command_register('nnn', open_func, 'Select file to open with external commandline')

return module
