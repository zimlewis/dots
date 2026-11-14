local module = {}
module.nnn_path = 'nnn -p -'
module.pwd = os.getenv('PWD')

vis:command_register('nnn', function(argv, force, win, selection, range)
	local command = string.format('%s %s', module.nnn_path, module.pwd)
	local file = io.popen(command)

	local output = {}
	for line in file:lines() do
		table.insert(output, line)
	end

	local success, msg, status = file:close()

	if status == 0 and #output >= 1 then
		vis:feedkeys(string.format(':e "%s"<Enter>', output[1]))
	elseif status ~= 0 then
		vis:info(string.format('nnn: Unknown exit status %d: %s', status, msg))
	end

	vis:feedkeys('<vis-redraw>')
	return true;
end, 'Select file to open with nnn')

return module
