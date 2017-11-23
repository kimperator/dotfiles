"nice color mode
colorscheme putty

"set omnicomplete to default
"autocmd Filetype * set omnifunc=syntaxcomplete#Complete

"win32 stuff || cygwin stuff
if has("win32") || isdirectory($WINDIR)
	"use win32 clipboard
	set clipboard=unnamed
	set makeprg=mingw32-make
	set guifont=Lucida\ Console/Regular/9
endif

"increase vim buffer to 50 files and yank buffer to 5000 lines
set viminfo='50,"5000

"use utf-8 as default file encoding and unix line ending
set enc=utf-8
set ff=unix

"some stupid stuff to fix for backspace with win32/cygwin
set backspace=eol,start,indent
noremap  
inoremap  

"get more options
set completeopt=longest,menuone

"yes this rocks, you can choose to write command or to complete,
"so you won't be forced to used autocompleted

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"eclipse like completetion omni mapping (ctrl + space)
inoremap <C-Space> <C-x><C-o>
"buggy vim on win32 o_O
inoremap <C-@> <C-x><C-o>

"dont resize terminal (be gnu screen & tmux friendly)
let Tlist_inc_Winwidth = 0

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

"let c++ omnicomplete handle c++17 syntax
let g:clang_c_options = '-std=gnu17'
let g:clang_cpp_options = '-xc++ -std=gnu++17 '
let g:clang_auto = 0

"fix for fish
set shell=sh

"tmux interaction
"ctrl+w left/right/up/down will work seamless
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-w><Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-w><Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-w><Up>   :TmuxNavigateUp<cr>
nnoremap <silent> <C-w><Right> :TmuxNavigateRight<cr>

"but be lazy, shift + left/up/down/right will work, too!
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up>   :TmuxNavigateUp<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>

"ctrl + e run command in (new) tmux windows, sends ctrl+c and executes the
"command
nnoremap <C-e> :call VimuxOpenRunner()<CR>:sleep 10m<CR>:call VimuxSendKeys("C-c")<CR>:sleep 20m<CR>:VimuxPromptCommand<CR>

"ctrl + l will run last command
nnoremap <C-l> :call VimuxSendKeys("C-c")<CR>:sleep 50m<CR>:VimuxRunLastCommand<CR>

"ctrl + f will reindent the current file
nnoremap <C-f> gg=G

"ctrl + t or f8 will show tagbar
nnoremap <C-t> :TagbarToggle<CR>
nnoremap <F8> :TagbarToggle<CR>


" Spelling
" default settings are no spelling enabled
set nospell
" change to german and english
set spelllang=de,en
let spellst = ["de", "en"]
" f2 will toggle spelling
map <F2> :set spell!<CR><Bar>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>
" they were using white on white
highlight PmenuSel ctermfg=black ctermbg=lightgray
" limit it to just the top 10 items
set sps=best,5
" highlighting
hi SpellBad ctermfg=Red ctermbg=Black cterm=underline
hi SpellCap ctermfg=blue ctermbg=black cterm=underline

"f4 find suggestion for spelled word
imap <F4> <ESC>z=<CR>i
nmap <F4> z=

"f5 add word to user dictionary
imap <F5> <ESC>zg<CR>i
nmap <F5> zg
