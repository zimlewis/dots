require('vis')
require('plugins/vis-fzf-open')
require('plugins/vis-autoclose')
require('plugins/vis-cursormode')
require('plugins/copypasta')
require('plugins/filetype')
-- require('plugins/vis-modal')

local browse = require('plugins/browse')
local tv_time = require('plugins/tv-time')
local pwd_track = require('plugins/pwd-track')
local lspc = require('plugins/vis-lspc')

lspc.logging = true
lspc.ls_map.gleam = {
	name = 'gleam-lsp',
	cmd = 'gleam lsp',
}

vis:map(vis.modes.NORMAL, ';', function(keys)
	vis:feedkeys(':')
end)

vis.events.subscribe(vis.events.INIT, function()
	vis:command('map! normal <C-p> :fzf<Enter>')

	-- Dependency injection
	pwd_track:set_from_env()
	tv_time.pwd_track = pwd_track
	browse.pwd_track = pwd_track

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

vis:command_register('pwd', function(argv, force, win, selection, range)
	if argv[1] == 'print' then
		vis:info(pwd_track:get_pwd())
		return true
	end

	local file = win.file
	local file_path = file.path
	if file_path == nil then
		return false
	end

	local last_slash = file_path:match('.*()%/')
	local folder_path = string.sub(file_path, 1, last_slash - 1)

	if string.len(folder_path) == 0 then
		return false
	end
	
	pwd_track:set_pwd(folder_path)
	return true;
end, 'set pwd to the folder contain file of current window or add a optional "print" argument to print current tracked pwd')


vis:map(vis.modes.NORMAL, ' lf', function() tv_time:live_grep() end, 'livegrep, using television tui')
vis:map(vis.modes.NORMAL, ' ff', function() tv_time:find_file() end, 'find file, using television tui')

vis:command_register('version', function(argv, force, win, selection, range)
	local api = vis.API
	if not api then
		local api_string = vis.VERSION:match('v%d*%.(%d*).*')
		api = api_string and tonumber(api_string) or 0
	end

	vis:info(string.format("vis.VERSION: %s, vis.API: %d", vis.VERSION, api))

	return true
end, 'Print the current vis.API version')

-- Filetypes
vis.ftdetect.extensions.zc = "zenc"
