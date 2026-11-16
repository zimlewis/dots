require('vis');
require('plugins/vis-fzf-open')
require('plugins/vis-autoclose')
require('plugins/browse')
require('plugins/vis-cursormode')
require('plugins/copypasta')

vis:map(vis.modes.NORMAL, ';', function(keys)
	vis:feedkeys(':')
end)

-- Mapping configuration example
vis.events.subscribe(vis.events.INIT, function()
	vis:command('map! normal <C-p> :fzf<Enter>')
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

	-- Theme
	vis:command('set theme default')
end)

