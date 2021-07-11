
let g:python3_host_prog = '/home/tinker/neovim3/bin/python'
" Install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:snipMate = { 'snippet_version' : 1 }
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')
if has('nvim')
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocompletion framework
  Plug 'bling/vim-airline' " 狀態欄
  "代碼補全 ----------------------"
  Plug 'ncm2/ncm2'
  Plug 'roxma/nvim-yarp'
  Plug 'HansPinckaers/ncm2-jedi'
  Plug 'davidhalter/jedi-vim'
  "---------------------------------"
  "tab 補全"
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
  " Optional:
  Plug 'honza/vim-snippets'
  "---------------------------------"
  Plug 'tell-k/vim-autopep8' "自動格式
  Plug 'mhinz/vim-startify' "啟動界面
  Plug 'jiangmiao/auto-pairs' " 自動括號
  Plug 'scrooloose/nerdtree' "nerdtree
  Plug 'zchee/deoplete-jedi' " autocompletion source
  Plug 'w0rp/ale' " using flake8
  Plug 'ludovicchabant/vim-gutentags' " create, maintain tags (using universal-ctags)
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'morhetz/gruvbox' "主題
  " TODO : look into these plugins:
  " Explore files
  " Plug 'tpope/vim-vinegar'
  " Plug 'justinmk/vim-dirvish'
  " Plug 'tpope/vim-projectionist'
  " Git integration
  " Plug 'airblade/vim-gitgutter'
  " Plug 'tpope/vim-fugitive'
  " Other
  " Plug 'vimwiki/vimwiki'
  " Plug 'tpope/vim-surround'
  " Plug 'wellle/targets.vim'
  " Plug 'justinmk/vim-sneak'
  " Plug 'tpope/vim-unimpaired'
  " Plug 'kein/rainbow_parentheses.vim'
  " Plug 'fisadev/vim-sort'
  " TODO: Find autocompletion, linting plugins for js, React
endif
call plug#end()


" General settings
" Remap leader
let mapleader="\<Space>"
" Finding files (:find), search down into subfolders, tab-completion
set path+=**
" Ignore case when searching unless upper case is used
set ignorecase
set smartcase
" Tab indent, settings
" Not sure exactly what is going on here, but these seem to give me what I
" need for now
" TODO: figure out how to set different tab values for different filetypes
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4


" Set absolute line number for the line under the cursor
set number
" Set relative line number for lines not under the cursor
set relativenumber
" Enable cursorline
set cursorline
" Set number of lines visible above/below the cursor when possible
set scrolloff=5
"
" Enable mouse support
set mouse=a


" Plugin settings
" deoplete.nvim, deoplete-jedi
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1


" ale, flake8 settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1


" tagbar
let g:tagbar_autofocus = 1
nnoremap <silent> <F4> :TagbarToggle<CR>

" papercolor-theme
set background=dark
colorscheme PaperColor

"f3 open nerdtree"
nnoremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"分屏窗口移動"
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
"f5 auto compile"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear":
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

"ctrl + s 保存"
imap <C-s> <Esc>:w!<CR>i
"ctrl+a copy all"
map <C-A> ggVG
map! <C-A> <Esc>ggVG
"ctrl+f 複製到剪貼簿"
map <C-F> "+y
map! <C-F> "+y
"nerdtree"
let NERDTreeChDirMode=2
let NERDChristmasTree=1
let NERDTreeMouseMode=1
let NERDTreeWinSize=25
let NERDTreeQuitOnOpen=1
autocmd VimEnter * NERDTree
"auto format"
let g:autopep8_disable_show_diff=1
"ncm2"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menu,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
let g:ncm2#matcher = 'substrfuzzy'
"jedi-vim"
let g:jedi#show_call_signatures = 1
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0

"----------------other--------------"
set history=1000
set nocompatible
syntax on
filetype plugin indent on
set ic "不分大小"
set hlsearch
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,GB2312,big5
set cursorline
set nu
set autoindent
set smartindent
set scrolloff=4
set showmatch
set backspace=indent,eol,start
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI","CompleteDone"]
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99
set background=dark
set cursorline
set cursorcolumn
colorscheme gruvbox
hi vertsplit ctermbg=bg guibg=bg
hi GitGutterAdd ctermbg=bg guibg=bg
hi GitGutterChange ctermbg=bg guibg=bg
hi GitGutterDelete ctermbg=bg guibg=bg
hi GitGutterChangeDelete ctermbg=bg guibg=bg
hi SyntasticErrorSign ctermbg=bg guibg=bg
hi SyntasticWarningSign ctermbg=bg guibg=bg
hi FoldColumn ctermbg=bg guibg=bg
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

func SetTitle() 
	if &filetype == ‘sh‘
         call setline(1,"\#########################################################################")
         call append(("."), "\# File Name: ".("%"))
         call append(line(".")+1, "\# Author: Stilesyu")
         call append(line(".")+2, "\# mail: yuxiaochen886@gmail.com")
    "call append((".")+3, "\# Created Time: ".strftime("%c"))
         call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
         call append(line(".")+4, "\#########################################################################")
         call append(line(".")+5, "\#!/bin/bash")
         call append(line(".")+6, "")
     else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".("%"))
        call append(line(".")+1, "    > Author: YourName")
        call append(line(".")+2, "    > Mail: YourEmail ")
        "call append((".")+3, "    > Created Time: ".strftime("%c"))
        call append((".")+3, "    > Created Time: ".strftime("%Y-%m-%d",localtime()))
        call append((".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
     endif
     if &filetype == ‘‘
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif

    if &filetype == ‘c‘
       call append(line(".")+6, "#include<stdio.h>")
       call append(line(".")+7, "")
    endif
    autocmd BufNewFile * normal G
 endfunc



highlight Normal guibg=NONE ctermbg=None
"jedi 配置"
let g:jedi#completions_command = "<C-N>"

nnoremap <A-j> ddp
nnoremap <A-k> ddP
nnoremap <A-l> xp
nnoremap<A-h> Xph
" au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' "
" au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock' "
