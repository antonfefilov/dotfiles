set nocompatible " choose no compatibility with legacy vi
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
" Plugin 'lifepillar/vim-solarized8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-eunuch'
Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
" supertab
Plugin 'ervandew/supertab'
" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'
" ultisnips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" tagbar
Plugin 'preservim/tagbar'
" ALE
Plugin 'dense-analysis/ale'
" Gitgutter
Plugin 'airblade/vim-gitgutter'
" Running tests from vim
Plugin 'thoughtbot/vim-rspec'

call vundle#end()

syntax on
set encoding=utf-8
set showcmd               " display incomplete commands
filetype plugin indent on " load file type plugins + indentation

" OmniFunc
set omnifunc=syntaxcomplete#Complete
" au FileType ruby,eruby setl ofu=rubycomplete#Complete
" au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
" au FileType c setl ofu=ccomplete#CompleteCpp
" au FileType css setl ofu=csscomplete#CompleteCSS

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
match ErrorMsg '\s\+$'          " mark trailing spaces as error

"" Remove trailing spaces with <Leader>rtw
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
"" Auto remove trailing spaces before save
autocmd BufWritePre * :%s/\s\+$//e

"" Searching
set hlsearch   " highlight matches
set incsearch  " incremental searching
set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

map <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR>:call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch! RUBYOPT='-W0' bin/rspec {spec}"

"" For understanding commands when in russian localization
set keymap=russian-jcukenwin
set iminsert=0
imap <F12> 
cmap <F12> 

" if $ITERM_PROFILE == 'Solarized Dark'
"   set background=dark
" else
"   set background=light
" endif
set background=light

colorscheme solarized " before solarized I used colorscheme spacegray

" airline
let g:airline#extensions#keymap#enabled = '0'
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

" if &background == 'dark'
"   let g:airline_solarized_bg='dark'
" else
"   let g:airline_solarized_bg='light'
" endif
let g:airline_solarized_bg='light'

"" For better displaying wrapped lines
set showbreak=↪

set number
set mouse=a

"" Folding
set foldmethod=indent
set foldlevelstart=1

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" buffer list
:nnoremap <F5> :buffers<CR>:buffer<Space>

" update current file whenever I leave it
autocmd BufLeave,FocusLost * silent! update

" automatically load the .vimrc file wheneaver I save it
au BufWritePost .vimrc so $MYVIMRC

" switch windows from home row
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" javascript goodies
let g:javascript_plugin_flow = 1        " pangloss/vim-javascript
let g:jsx_ext_required = 0              " mxw/vim-jsx
" let g:spacegray_underline_search = 1    " spacegray.vim
" let g:spacegray_italicize_comments = 1  " spacegray.vim
let g:ale_lint_on_save = 1              " w0rp/ale
let g:ale_lint_on_text_changed = 0      " w0rp/ale

" " put a new line after line with cursor
" map <Enter> o<ESC>

" Disable highlights when press <leader><cr>
map <silent> <leader><cr> :noh<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Open MRU.vim to see the recently open files
map <leader>f :MRU<CR>

" Mapping for Goyo
map <leader>z :Goyo<cr>

" LimeLight - Goyo integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" ultisnips
" let g:UltiSnipsExpandTrigger       = "<C-l>"
" let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" LSP servers
let g:ycm_language_server = [
  \ {
  \   'name': 'ruby',
  \   'cmdline': [ expand( '~/.rbenv/versions/2.7.0/bin/solargraph'  ), 'stdio'  ],
  \   'filetypes': [ 'ruby'  ],
  \ },
  \ ]
