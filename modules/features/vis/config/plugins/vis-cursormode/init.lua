local M = {
}

M.styles = {
	normal = "back:blue,fore:black,keep_attribute",
	insert = "default,keep_attribute,underlined",
}

M.last_mode = nil

function M.update()
	local mode = vis.mode

	if mode == M.last_mode then
		return
	end

	M.last_mode = mode

	local style = M.styles.normal
	if mode == vis.modes.INSERT or mode == vis.modes.REPLACE then
		style = M.styles.insert
	end

	vis.ui:style_define(vis.ui.style_ids.CURSOR, style)
	vis.ui:style_define(vis.ui.style_ids.CURSOR_PRIMARY, style)
end

vis.events.subscribe(vis.events.WIN_HIGHLIGHT, M.update)
return M
