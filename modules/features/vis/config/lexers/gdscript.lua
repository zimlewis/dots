-- Copyright 2026. See LICENSE.
-- GDScript LPeg lexer for Scintillua (Textadept, SciTE, Vis).

local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, S = lpeg.P, lpeg.S

local lex = lexer.new('gdscript', {fold_by_indentation = true})

-- Whitespace
lex:add_rule('whitespace', token(lexer.WHITESPACE, lexer.space^1))

-- Keywords (Godot 4.x)
lex:add_rule('keyword', token(lexer.KEYWORD, word_match{
	'if', 'elif', 'else', 'for', 'while', 'match', 'when',
	'break', 'continue', 'pass', 'return',
	'class', 'class_name', 'extends', 'is', 'in', 'as',
	'self', 'super', 'signal', 'func', 'static', 'const',
	'enum', 'var', 'breakpoint', 'preload', 'await', 'yield',
	'assert', 'void', 'PI', 'TAU', 'INF', 'NAN',
	'and', 'or', 'not'
}))

-- Annotations (@export, @onready, @tool, etc.)
lex:add_rule('annotation', token(lexer.ANNOTATION, '@' * lexer.word))

-- Built-in Types & Constants
lex:add_rule('type', token(lexer.TYPE, word_match{
	'null', 'true', 'false', 'bool', 'int', 'float', 'String',
	'Vector2', 'Vector2i', 'Rect2', 'Rect2i', 'Vector3', 'Vector3i',
	'Transform2D', 'Vector4', 'Vector4i', 'Plane', 'Quaternion',
	'AABB', 'Basis', 'Transform3D', 'Projection', 'Color',
	'StringName', 'NodePath', 'RID', 'Object', 'Callable', 'Signal',
	'Dictionary', 'Array', 'PackedByteArray', 'PackedInt32Array',
	'PackedInt64Array', 'PackedFloat32Array', 'PackedFloat64Array',
	'PackedStringArray', 'PackedVector2Array', 'PackedVector3Array',
	'PackedColorArray', 'Variant'
}))

-- Built-in Functions
lex:add_rule('function', token(lexer.FUNCTION_BUILTIN, word_match{
	'abs', 'acos', 'asin', 'atan', 'atan2', 'ceil', 'clamp', 'cos',
	'deg_to_rad', 'ease', 'exp', 'floor', 'fmod', 'fposmod', 'lerp',
	'log', 'max', 'min', 'move_toward', 'pow', 'rad_to_deg', 'randf',
	'randf_range', 'randi', 'randi_range', 'randomize', 'round',
	'seed', 'sign', 'sin', 'snapped', 'sqrt', 'step_decimals', 'tan',
	'print', 'printerr', 'printraw', 'prints', 'printt', 'push_error',
	'push_warning', 'str', 'typeof', 'type_exists', 'load', 'weakref',
	'instance_from_id', 'is_instance_id_valid', 'is_instance_valid',
	'range', 'len'
}))

-- Identifiers
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Comments
lex:add_rule('comment', token(lexer.COMMENT, lexer.to_eol('#')))

-- Strings (including multiline triple quotes and NodePaths/StringNames)
local sq_str = lexer.range("'")
local dq_str = lexer.range('"')
local tq_str = lexer.range("'''") + lexer.range('"""')
local prefix = S('r&^')^-1
lex:add_rule('string', token(lexer.STRING, prefix * (tq_str + sq_str + dq_str)))

-- Numbers (hex, binary, float, int with underscores)
local dec = lexer.digit * (lexer.digit + '_')^0
local hex = '0' * S('xX') * (lexer.xdigit + '_')^1
local bin = '0' * S('bB') * S('01_')^1
local float = (dec^0 * '.' * dec + dec * '.') * (S('eE') * S('+-')^-1 * dec)^-1
lex:add_rule('number', token(lexer.NUMBER, hex + bin + float + dec))

-- NodePath shorthand ($Node/Path and %UniqueNode)
lex:add_rule('variable', token(lexer.VARIABLE, S('$%') * (lexer.word + '/')^1))

-- Operators
lex:add_rule('operator', token(lexer.OPERATOR, S('+-*/%&|^~<>!=?:;.,()[]{}')))

return lex
