"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
" zo to open single fold
" zc to close the fold
" zR to open all folds
" zM to close all folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
filetype on
filetype indent on

" EVERFOREST THEME ---------------------------------------------------- {{{
packadd! everforest

" Important!!
if has('termguicolors')
set termguicolors
endif

" For dark version.
set background=dark

" For light version.
"set background=light

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest

" }}}


" Numberline Setting
set relativenumber

" Syntax
syntax on

" Cursor Settings
set cursorline
set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

set nowrap

set showcmd

set showmode

set showmatch

set hlsearch

set wildmenu

set wildmode=list:longest

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}

" STATUS LINE --------------------------------------------------------- {{{
" Current mode
let g:currentmode={
      \ 'n'  : 'n',
      \ 'v'  : 'v',
      \ 'V'  : 'vl',
      \ '' : 'vb',
      \ 'i'  : 'i',
      \ 'R'  : 'r',
      \ 'Rv' : 'rv',
      \ 'c'  : 'c',
      \ 't'  : 'f',
      \}

" Define highlight groups for different modes
hi NormalColor ctermbg=black ctermfg=white
hi InsertColor ctermbg=darkgreen ctermfg=black
hi ReplaceColor ctermbg=darkred ctermfg=black
hi VisualColor  ctermbg=darkblue ctermfg=black

set laststatus=2
set statusline=
set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#InsertColor#%{(g:currentmode[mode()]=='i')?'\ \ INSERT\ ':''}
set statusline+=%#ReplaceColor#%{(g:currentmode[mode()]=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#ReplaceColor#%{(g:currentmode[mode()]=='rv')?'\ \ V-REPLACE\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='vl')?'\ \ V-LINE\ ':''}
set statusline+=%#VisualColor#%{(g:currentmode[mode()]=='vb')?'\ \ V-BLOCK\ ':''}
set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='c')?'\ \ COMMAND\ ':''}
set statusline+=%#NormalColor#%{(g:currentmode[mode()]=='f')?'\ \ FINDER\ ':''}
set statusline+=%-{b:gitbranch}
set statusline+=%-.20F	" Full path
set statusline+=%-M	" Full path
set statusline+=%=	" Switch to right side
set statusline+=%y	" File type
set statusline+=Line\ %l\ of\ %L	" Line number
set statusline+=%1*

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END
" }}}

" Transparente BG
hi Normal guibg=NONE ctermbg=NONE
