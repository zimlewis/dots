-- Catppuccin Mocha for reference, this won't work well if the terminal emulator doesn't match this exact color
local lexers = vis.lexers

local colors = {
	rosewater = '#f5e0dc',
	flamingo  = '#f2cdcd',
	pink      = '#f5c2e7',
	mauve     = '#cba6f7',
	red       = '#f38ba8',
	maroon    = '#eba0ac',
	peach     = '#fab387',
	yellow    = '#f9e2af',
	green     = '#a6e3a1',
	teal      = '#94e2d5',
	sky       = '#89dceb',
	sapphire  = '#74c7ec',
	blue      = '#89b4fa',
	lavender  = '#b4befe',
	text      = '#cdd6f4',
	overlay0  = '#6c7086',
	surface1  = '#45475a',
	surface0  = '#313244',
	base      = '#1e1e2e',
	mantle    = '#181825',
}

lexers.STYLE_DEFAULT      = 'fore:'..colors.text..',back:'..colors.base
lexers.STYLE_NOTHING      = 'back:'..colors.base
lexers.STYLE_CLASS        = 'fore:'..colors.yellow
lexers.STYLE_COMMENT      = 'fore:'..colors.overlay0..',italics'
lexers.STYLE_CONSTANT     = 'fore:'..colors.peach
lexers.STYLE_DEFINITION   = 'fore:'..colors.blue
lexers.STYLE_ERROR        = 'fore:'..colors.red..',bold'
lexers.STYLE_FUNCTION     = 'fore:'..colors.blue
lexers.STYLE_KEYWORD      = 'fore:'..colors.mauve
lexers.STYLE_LABEL        = 'fore:'..colors.sapphire
lexers.STYLE_NUMBER       = 'fore:'..colors.peach
lexers.STYLE_OPERATOR     = 'fore:'..colors.sky
lexers.STYLE_REGEX        = 'fore:'..colors.pink
lexers.STYLE_STRING       = 'fore:'..colors.green
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.pink
lexers.STYLE_TAG          = 'fore:'..colors.blue
lexers.STYLE_TYPE         = 'fore:'..colors.yellow
lexers.STYLE_VARIABLE     = 'fore:'..colors.lavender
lexers.STYLE_WHITESPACE   = ''
lexers.STYLE_EMBEDDED     = 'fore:'..colors.teal
lexers.STYLE_IDENTIFIER   = 'fore:'..colors.text

-- Vis UI Styles
lexers.STYLE_LINENUMBER        = 'fore:'..colors.overlay0..',back:'..colors.base
lexers.STYLE_LINENUMBER_CURSOR = 'fore:'..colors.lavender..',back:'..colors.base
lexers.STYLE_CURSOR            = 'fore:'..colors.base..',back:'..colors.rosewater
lexers.STYLE_CURSOR_PRIMARY    = 'fore:'..colors.base..',back:'..colors.rosewater
lexers.STYLE_CURSOR_LINE       = 'back:'..colors.surface0
lexers.STYLE_COLOR_COLUMN      = 'back:'..colors.surface0
lexers.STYLE_SELECTION         = 'back:'..colors.surface1
lexers.STYLE_STATUS            = 'fore:'..colors.text..',back:'..colors.mantle
lexers.STYLE_STATUS_FOCUSED    = 'fore:'..colors.mauve..',back:'..colors.mantle..',bold'
lexers.STYLE_SEPARATOR         = 'fore:'..colors.surface0
lexers.STYLE_INFO              = 'fore:'..colors.peach..',back:'..colors.mantle
lexers.STYLE_EOF               = 'fore:'..colors.surface1
