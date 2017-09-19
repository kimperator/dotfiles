" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"  copy $HOME/.vim to $HOME/vimfiles/
"	    for OpenVMS:  sys$login:.vimrc

"nice color mode
colorscheme putty

"sets default complete
"autocmd Filetype * set omnifunc=syntaxcomplete#Complete

"win32 stuff || cygwin stuff
if has("win32") || isdirectory($WINDIR)
	"use win32 clipboard
	set clipboard=unnamed
	set makeprg=mingw32-make
	set guifont=Lucida\ Console/Regular/9
endif

"ctags stuff
if has("win32")
	"win32 (g)VIM
	let g:uservim = "$HOME\\vimfiles\\"
	let g:usertags = g:uservim."tags\\"
	let g:ctags_bin= g:uservim."bin\\win32\\ctags.exe"
elseif isdirectory($WINDIR)
	"cygwin VIM
	let g:uservim = "$HOME/.vim/"
	let g:ctags_bin=g:uservim."/bin/cygwin/ctags.exe"
	let g:usertags = g:uservim."tags/"
else
	"posix VIM
	let g:uservim = "$HOME/.vim/"
	let g:ctags_bin="ctags"
	let g:usertags = g:uservim."tags/"
endif

let Tlist_Ctags_Cmd=expand(g:ctags_bin)

"increase vim buffer to 50 files and yank buffer to 5000 lines
set viminfo='50,"5000

"use utf-8 as default file encoding and line ending
set enc=utf-8
set ff=unix

"some stupid stuff to fix for backspace
set backspace=eol,start,indent
noremap  
inoremap  

"stuff for omnicomplete
set nocp
filetype plugin on

"python stuff
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"Don't show docs in preview window
au FileType python setlocal completeopt-=preview
"Error at :make
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 

"this is defined in python PEP8 programming guide
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
let t_python=g:usertags."python"
autocmd FileType python execute ':setlocal tags+='.t_python

"web stuff
au FileType xhtml,html,htm,php,xml filetype plugin indent on
au FileType xhtml,html,htm,php,xml setlocal ts=2 sw=2 expandtab
autocmd FileType sql set omnifunc=sqlcomplete#Complete
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd BufNewFile,BufRead *.csv setf csv
let g:csv_delimiter = "\t"

"java stuff
autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
au FileType java setlocal makeprg=ant

"c sharp stuff
"autocmd FileType cs setlocal omnifunc=ccomplete#Complete
au FileType cs set omnifunc=syntaxcomplete#Complete
au FileType cs setlocal foldmethod=marker
au FileType cs setlocal foldmarker={,}
au FileType cs setlocal foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
au FileType cs setlocal foldlevelstart=2  

"c++ and c stuff
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete

let t_glibc = g:usertags."glibc"
autocmd FileType c,cpp execute ':setlocal tags+='.t_glibc

"other file specific stuff
au BufReadCmd *.jar,*.xpi,*.apk call zip#Browse(expand("<amatch>"))

"tag files, build with 
if has("win32")
	let t_stdcpp = g:usertags."cpp_win32"
	autocmd FileType cpp execute ':setlocal tags+='.t_stdcpp
else
	let t_stdcpp = g:usertags."cpp_posix"
	autocmd FileType cpp execute ':setlocal tags+='.t_stdcpp
endif
let t_sdl = g:usertags."SDL"
autocmd FileType c,cpp execute ':setlocal tags+='.t_sdl

let t_gl = g:usertags."GL"
autocmd FileType c,cpp execute ':setlocal tags+='.t_gl

let t_opencv = g:usertags."opencv"
autocmd FileType c,cpp execute ':setlocal tags+='.t_opencv

let t_cl = g:usertags."opencl"
autocmd FileType c,cpp execute ':setlocal tags+='.t_cl



"get more options
set completeopt=longest,menuone

"yes this rocks, you can choose to write command or to complete,
"so you won't be forced to used autocompleted

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"eclipse like completetion omni mapping (ctrl + space)
inoremap <C-Space> <C-x><C-o>
"buggy vim oO
inoremap <C-@> <C-x><C-o>

"taglist
"CTRL+b = build project related tags
"map <C-b> :echo silent ctags . -R --fields=+iaS --extra=+q . 2>&1 > /dev/null <CR><CR>;
function! UpdateCTags()
	if has("win32")
		let _result_ = system("del tags")
	else
		let _result_ = system("rm tags")
	endif
	unlet _result_
	let _result_ = system(g:ctags_bin ." . -R --fields=+iaS --extra=+q .")
	unlet _result_
	redraw
endfunction

"map manualy on ctrl + b building tags file
"map <C-b> :call UpdateCTags() <CR> <CR>
"map auto build new tag file on write
autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateCTags()

"dont resize terminal (be gnu screen friendly)
let Tlist_inc_Winwidth = 0

"CTRL+t = TagList of active File
map <C-t> :TlistToggle<CR>

"CTRL+o (open) nerdtree to choose file
map <C-o> :NERDTreeToggle<CR>
"ignore some files
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']
"show line number in files
set number

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"if &term == "screen"
"	set t_kN=^[[6;*~
"	set t_kP=^[[5;*~
"endif

