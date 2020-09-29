execute pathogen#infect()

set nocompatible                " choose no compatibility with legacy vi
syntax on
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
match ErrorMsg '\s\+$'          " mark trailing spaces as error

"" Remove trailing spaces with <Leader>rtw
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
autocmd BufWritePre * :%s/\s\+$//e

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

map <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <F8> :TlistToggle<CR>

" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :w<CR>:call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"" let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"
let g:rspec_command = "Dispatch! RUBYOPT='-W0' bin/rspec {spec}"

"" For understanding commands when in russian localization
set keymap=russian-jcukenwin
set iminsert=0
imap <F12> 
cmap <F12> 

"" This is for best coloring
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

if has('gui_running')
  set background=light
  colorscheme solarized
else
  set background=dark
  colorscheme spacegray
endif

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
let g:spacegray_underline_search = 1    " spacegray.vim
let g:spacegray_italicize_comments = 1  " spacegray.vim
let g:ale_lint_on_save = 1              " w0rp/ale
let g:ale_lint_on_text_changed = 0      " w0rp/ale

" airline
let g:airline#extensions#keymap#enabled = '0'

" ultisnips
let g:UltiSnipsExpandTrigger       = "<C-l>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" put a new line after line with cursor
map <Enter> o<ESC>

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

" LSP servers
let g:ycm_language_server = [
  \ {
  \   'name': 'ruby',
  \   'cmdline': [ expand( '/home/haul/.rbenv/versions/2.7.0/bin/solargraph'  ), 'stdio'  ],
  \   'filetypes': [ 'ruby'  ],
  \ },
  \ ]
