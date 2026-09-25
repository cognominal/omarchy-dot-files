" Vim filetype plugin for .rak (Raku dialect)
" Inherit settings from raku's ftplugin
runtime! ftplugin/raku.vim

" .rak-specific options
setlocal formatoptions-=t
setlocal formatoptions+=crqol
setlocal keywordprg=raku

" .rak files use the new dialect — point at rak executable if available
if executable("rak")
  setlocal makeprg=rak\ %
endif