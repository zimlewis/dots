-- Zen-C LPeg lexer for vis.
-- Based on the Zen-C lexical structure: https://github.com/zenc-lang/docs/blob/main/lex.md

local lexer = require('lexer')
local token, word_match = lexer.token, lexer.word_match
local P, S, V = lpeg.P, lpeg.S, lpeg.V

local lex = lexer.new('zenc')

-- Whitespace.
local ws = token(lexer.WHITESPACE, lexer.space^1)
lex:add_rule('whitespace', ws)

-- Comments: `// ...` and nestable `/* ... /* ... */ ... */`.
local line_comment = lexer.to_eol('//')
local block_comment = P{
  'block',
  block = '/*' * (V('block') + (P(1) - '*/'))^0 * P('*/')^-1,
}
lex:add_rule('comment', token(lexer.COMMENT, line_comment + block_comment))

-- Strings: "...", """...""", f"...", f"""...""", r"...", r"""...""".
local escape = P('\\') * P(1)
local tq_str = P('"""') * (escape + (P(1) - P('"""')))^0 * P('"""')^-1
local dq_str = P('"') * (escape + (P(1) - S('"\\\n')))^0 * P('"')^-1
local raw_tq = P('r"""') * (P(1) - P('"""'))^0 * P('"""')^-1
local raw_dq = P('r"') * (P(1) - P('"'))^0 * P('"')^-1
local f_tq = P('f') * tq_str
local f_dq = P('f') * dq_str
local str = tq_str + f_tq + raw_tq + dq_str + f_dq + raw_dq

-- Character literals: 'a', '\n', '\u00e9'.
local chr = P("'") * (
  P('\\') * (P('u') * lexer.xdigit^4 + P(1)) +
  (P(1) - S("'\\\n"))
) * P("'")

lex:add_rule('string', token(lexer.STRING, str + chr))

-- Numbers: decimal, 0x hex, 0o octal, 0b binary, floats; any alphanumeric
-- run after the digits is consumed as a suffix (u, L, u64, f, ...).
local dec = lexer.digit^1
local suffix = (lexer.alnum + '_')^0
local exp = S('eE') * S('+-')^-1 * dec
local radix = (P('0x') * lexer.xdigit^1 + P('0o') * S('01234567')^1 + P('0b') * S('01')^1) * suffix
-- `-P('.')` keeps ranges like `0..10` from being lexed as a float.
local float = (dec * '.' * -P('.') * lexer.digit^0 * exp^-1 + dec * exp) * suffix
lex:add_rule('number', token(lexer.NUMBER, radix + float + dec * suffix))

-- Declarations that introduce a name: `fn name`, `struct Name`, ...
lex:add_rule('fn_decl', token(lexer.KEYWORD, word_match('fn')) * ws * token(lexer.FUNCTION, lexer.word))
lex:add_rule('type_decl', token(lexer.KEYWORD, word_match('struct enum union trait impl alias opaque')) * ws * token(lexer.TYPE, lexer.word))

-- Keywords.
lex:add_rule('keyword', token(lexer.KEYWORD, word_match[[
  let def fn struct enum union alias trait impl use module import opaque
  if else match for while loop return break continue guard unless defer
  async await try catch goto
  asm assert test sizeof embed comptime autofree volatile launch ref static const
  and or
  auto case default do extern inline register restrict switch typedef
  _Atomic _Generic _Noreturn _Static_assert _Thread_local
]]))

-- Constants.
lex:add_rule('constant', token(lexer.CONSTANT, word_match[[true false null]]))

-- Built-in types.
lex:add_rule('type', token(lexer.TYPE, word_match[[
  i8 i16 i32 i64 i128 u8 u16 u32 u64 u128 isize usize f32 f64
  bool char string void byte rune int uint float
  c_char c_schar c_uchar c_short c_ushort c_int c_uint c_long c_ulong
  c_longlong c_ulonglong c_float c_double
  double long short signed unsigned _Bool _Complex _Imaginary
]]))

-- Attributes / directives, e.g. `@derive(...)`.
lex:add_rule('annotation', token(lexer.PREPROCESSOR, P('@') * lexer.word))

-- Function calls: identifier directly followed by `(`.
lex:add_rule('function', token(lexer.FUNCTION, lexer.word * #(lexer.space^0 * '(')))

-- ALL_CAPS names are constants; Capitalized names are types (by convention).
local word_chars = lexer.alnum + '_'
lex:add_rule('constant_name', token(lexer.CONSTANT, lexer.upper * (lexer.upper + lexer.digit + '_')^1 * -word_chars))
lex:add_rule('type_name', token(lexer.TYPE, lexer.upper * word_chars^0))

-- Identifiers.
lex:add_rule('identifier', token(lexer.IDENTIFIER, lexer.word))

-- Operators and punctuation.
lex:add_rule('operator', token(lexer.OPERATOR, S('+-*/%&|^~<>=!?.:,;()[]{}')))

-- Fold points.
lex:add_fold_point(lexer.OPERATOR, '{', '}')
lex:add_fold_point(lexer.COMMENT, '/*', '*/')
lex:add_fold_point(lexer.COMMENT, lexer.fold_consecutive_lines('//'))

return lex