require('vis');
require('plugins/vis-fzf-open')
require('plugins/vis-autoclose')
require('plugins/browse')
require('plugins/vis-cursormode')
require('plugins/copypasta')

local lspc = require('plugins/vis-lspc')
lspc.logging = true

vis:map(vis.modes.NORMAL, ';', function(keys)
	vis:feedkeys(':')
end)

-- Mapping configuration example
vis.events.subscribe(vis.events.INIT, function()
	vis:command('map! normal <C-p> :fzf<Enter>')
	-- Theme
	vis:command('set theme default')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Window options
	vis:command('set numbers on')
	vis:command('set relativenumbers on')
	vis:command('set tabwidth 4')
	vis:command('set autoindent on')
	vis:command('set showeof false')
	vis:command('set wrapcolumn 0')

	-- Vis options
	vis:command('set shell bash')
end)


vis:command_register("version", function(argv, force, win, selection, range)
	local api = vis.API
	if not api then
		local api_string = vis.VERSION:match('v%d*%.(%d*).*')
		api = api_string and tonumber(api_string) or 0
	end

	vis:info(string.format("vis.VERSION: %s, vis.API: %d", vis.VERSION, api))

	return true
end, "Print the current vis.API version")
