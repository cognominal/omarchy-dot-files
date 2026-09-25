" Vim syntax file
" Language:      Raku `.rak` dialect
" Maintainer:    LazyVim user config
" Description:   Extends raku.vim with .rak-specific syntax:
"                redirection operators, naked strings, dotty semantics.

" Load the base Raku syntax
runtime! syntax/raku.vim

" ============================================
" Redirection operators
" Output redirection: >filename, >>filename (appended directly to filename)
" Input redirection:  <filename (at start of statement)
" Note: must touch the filename (no space between operator and filename).
" When there IS a space, it's a comparison, handled by rakuOperator already.
" ============================================

" Output redirection at end of statement: say x >out.txt
" The '>' or '>>' must directly touch the filename.
" Filename can be bare, quoted single, or quoted double.
syn match rakRedirOut  display '>[A-Za-z0-9_/.~$@%&][A-Za-z0-9_./~$@%&#''"-]*'
syn match rakRedirOut  display ">'[^']*'"
syn match rakRedirOut  display '>"[^"]*"'
syn match rakRedirApp  display '>>[A-Za-z0-9_/.~$@%&][A-Za-z0-9_./~$@%&#''"-]*'
syn match rakRedirApp  display ">>'[^']*'"
syn match rakRedirApp  display '>>"[^"]*"'

" Input redirection at start of statement: <input.txt say x
syn match rakRedirIn   display '^\s*<[A-Za-z0-9_/.~$@%&][A-Za-z0-9_./~$@%&#''"-]*'
syn match rakRedirIn   display "^\s*<'[^']*'"
syn match rakRedirIn   display '^\s*<"[^"]*"'

" ============================================
" Naked strings
" Unquoted string literals in .rak syntax.
" A token starting with [a-zA-Z], containing no whitespace, that isn't a
" variable ($@%&), keyword, or number literal.
" We match tokens that look like identifiers but aren't already highlighted
" as keywords, types, or variables by the base raku syntax.
" ============================================

" A naked string is an alphanumeric token that appears:
" - after a statement-start (optional whitespace, not on a keyword line)
" - after an operator
" We rely on the base raku syntax to handle keywords, types, variables.
" Everything left-over alphanumeric-ish that starts with a letter is a naked string.
syn match rakNakedString display '\<[A-Za-z][A-Za-z0-9_.-]*[A-Za-z0-9]\>' contains=NONE

" ============================================
" Dotty semantics
" .name  → attribute access (like <name>)
" ->name → method call
" ============================================

" Dot prefix for attribute access: .identifier
" Must be preceded by whitespace or start of line (not part of a number or string)
syn match rakDottyAttr display '\.\h\w*'

" Arrow prefix for method calls: ->identifier
syn match rakDottyCall display '->\h\w*'

" ============================================
" Highlight links
" ============================================

" Redirection operators - use Special or Operator highlighting
hi def link rakRedirOut  Special
hi def link rakRedirApp  Special
hi def link rakRedirIn   Special

" Naked strings - use String highlighting (like quoted strings)
hi def link rakNakedString String

" Dotty syntax - use Function or Identifier highlighting
hi def link rakDottyAttr  Typedef
hi def link rakDottyCall  Function