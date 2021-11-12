"
" Plugins
" Install plugins: :PlugInstall
"
call plug#begin('~/.vim/plugins') " Specify a directory for plugins

" Quickly and easily change ' to "
Plug 'tpope/vim-surround'

" Enable git-shortcuts in vim, ex:  :Gmove (rename file, delete old buffer)
Plug 'tpope/vim-fugitive'

" Jellybean color theme
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }

" Quickly go to file with name containing.. fuzzy search
Plug 'kien/ctrlp.vim'

" Silver searcher (Ag)
" Install: brew install the_silver_searche ( brew is mac specific )
Plug 'rking/ag.vim'

" Automatically add end when entering new line in Elixir/Ruby for example.
Plug 'tpope/vim-endwise'

" emmet - html autocompletion
Plug 'mattn/emmet-vim'

" Nerdtree
Plug 'scrooloose/nerdtree'

" Elixir settings for vim
Plug 'elixir-lang/vim-elixir'

" https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
" https://github.com/plasticboy/vim-markdown/#installation
Plug 'plasticboy/vim-markdown/'

Plug 'jlong/sass-convert.vim'
Plug 'godlygeek/tabular'

" Initialize plugin system
call plug#end()

" . . . . . end of plugins section . . . . . . .


" Colors & font
colorscheme jellybeans
set guifont=Monaco:h13

" Quick ESC ( om jag trycker ö två gånger i följd snabbt så växlar vim ifrån
" insertläge till command-läge :] )
imap öö <ESC>


" Snabbspara med Space + S
noremap <Leader>s :update<CR>

" Snabbspara med F3 när jag är i insertmode
" F3 för att jag inte bestämt mig för vilken knapp jag vill använda ännu och
" detta är med som hjälpsamt exempel på hur inoremap lirar :]
inoremap <F3> <C-O>:w<CR>

" Automatically create missing folders when saving file
" http://vi.stackexchange.com/questions/678/how-do-i-save-a-file-in-a-directory-that-does-not-yet-exist
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

" Automatically save changes to file, when switching away from vim
au FocusLost * :wa

" Make -space button- the vim leader button
" Needs to be set before any <leader> commands, else it'll bind the wrong
" keys to those commands!
let mapleader=" "

" CtrlP
let g:ctrlp_max_height = 42
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(css)$',
  \ }

" Ag silver searcher settings
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " use ag in CtrlP for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough to CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|botright cwindow|redraw!
nnoremap <leader>a :Ag 
" - - - - end of Ag Silver searcher settings - - - -

" Tab between buffers (ex tab down to Ag search results buffer)
nnoremap <tab> <c-w><c-w>

" vim settings
set autoread "Automatically reload files that have changed (ex, switching from one branch to another)
set encoding=utf-8  " The encoding displayed.
set expandtab
set fileencoding=utf-8  " The encoding written to file.
set hidden " allow switching from changed buffers
set nowrap " don't wrap lines
set number " show line numbers
set nowritebackup " I think this stops vim from warning me about hidden buffers
set tabstop=2
set shiftwidth=2
set noswapfile "don't create .swp (swapfiles) - not needed on localhost! :)
set list listchars=tab:>-,trail:.,extends:> " set ignorecase " If I want to search FOO foo and Foo whedn typing /foo




" Victorias elixir-uppsättning
imap <D-ä> <%=  %><left><left><left>
imap <D-ö> (  )<left><left>

" iab - insert abbreviation
iab innn \|> IO.inspect
iab modo @moduledoc """
\<CR>
\<CR>"""<Up>
" map
" % from <D-j> in Cmd + J in insert mode and {} and then move one step left :)
imap <D-j> %{  }<left><left>

" Tuple
" % from <D-j> in Cmd + J in insert mode and {} and then move one step left :)
imap <D-k> {  }<left><left>
imap <D-K> {{  }}<left><left><left>
imap <C-D-k> {%  %}<left><left>
imap <D-h> #{  }<left><left>
imap <D-l> [  ]<left><left>
imap <D-d> <ESC><right>a
imap <D-D> <ESC><left>a
imap <D-i> \|
imap <D-f> , fn() -><left><left><left><left>
imap <D-F> fn() -><left><left><left><left>

" https://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
" https://github.com/plasticboy/vim-markdown/#installation
 let g:vim_markdown_folding_disabled = 1



" Strip trailing spaces on lost focus/save + keep location
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType eex,php,ruby,python,html,md,css,sass,scss,eex,ex,exs,js,javascript,json,elixir,eelixir,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
