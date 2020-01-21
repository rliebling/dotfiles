" plugins using vim_plug
call plug#begin('~/.vim/plugged')

Plug 'NLKNguyen/papercolor-theme'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
"Plug 'slashmili/alchemist.vim'
"Plug 'dense-analysis/ale'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-projectionist'
"Plug 'c-brenn/fuzzy-projectionist.vim'
Plug 'andyl/vim-projectionist-elixir'
Plug 'akhil/scala-vim-bundle'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'bkad/CamelCaseMotion'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'junegunn/vim-easy-align'
Plug 'gaving/vim-textobj-argument'
Plug 'vim-latex/vim-latex'
Plug 'Shougo/neoyank.vim'
Plug 'osyo-manga/unite-quickfix'
call plug#end()

let mapleader = ","

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}


" from https://github.com/prabirshrestha/vim-lsp
let g:lsp_settings = {
\ 'elixirLS': { 'workspace_config': {'dialyzerEnabled': v:false}}
\}
let g:lsp_diagnostics_enabled = 1
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"   " ALE settings (taken from https://github.com/mhanberg/.dotfiles/blob/master/vimrc#L97
"   "let g:ale_elixir_elixir_ls_release = '$HOME/bin/elixir-ls.sh'
"   let g:ale_elixir_elixir_ls_release = '/Users/rliebling/workspace/elixir-ls/rel'
"   let g:ale_completion_enabled = 1
"   autocmd FileType elixir nnoremap <c-]> :ALEGoToDefinition<cr>
"   let g:ale_linters = {}
"   let g:ale_linters.elixir = ['elixir-ls']
"   "let g:ale_linters.scss = ['stylelint']
"   "let g:ale_linters.css = ['stylelint']
"   "
"   let g:ale_fixers = {}
"   "let g:ale_fixers.javascript = ['eslint']
"   "let g:ale_fixers.scss = ['stylelint']
"   "let g:ale_fixers.css = ['stylelint']
"   "let g:ale_fixers.elm = ['format']
"   "let g:ale_fixers.ruby = ['rubocop']
"   " https://www.rockyourcode.com/developing-with-elixir-in-vim/
"   let g:ale_fixers.elixir = ['mix_format']
"   let g:ale_sign_error = '✘'
"   let g:ale_sign_warning = '⚠'
"   let g:ale_lint_on_enter = 0
"   let g:ale_lint_on_text_changed = 'never'
"   highlight ALEErrorSign ctermbg=NONE ctermfg=red
"   highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"   let g:ale_linters_explicit = 1
"   let g:ale_lint_on_save = 1
"   let g:ale_fix_on_save = 1
"   
"   noremap <Leader>ad :ALEGoToDefinition<CR>
"   nnoremap <leader>af :ALEFix<cr>
"   noremap <Leader>ar :ALEFindReferences<CR>
"   
"   "Move between linting errors
"   nnoremap ]r :ALENextWrap<CR>
"   nnoremap [r :ALEPreviousWrap<CR>
"   "nnoremap df :ALEFix<cr>

" denite settings
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  inoremap <silent><buffer> <Down>
  \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
  inoremap <silent><buffer> <Up>
  \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
endfunction


" goal is to have unite respect .gitignore file
" from https://coderwall.com/p/pwh5jg/ignoring-gitignore-files-in-unite-vim
" let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
call denite#custom#alias('source', 'file/rec/test', 'file/rec')
call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', '', '--ignore', 'test/'])
call denite#custom#var('file/rec/test', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', 'test/'])

"    call unite#filters#matcher_default#use(['matcher_fuzzy'])
"    call unite#filters#sorter_default#use(['sorter_rank'])
"    " call unite#set_profile('files', 'smartcase', 1)
"    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
"    call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
" Change matchers.
call denite#custom#source(
\ 'file_mru', 'matchers', ['matcher/fuzzy', 'matcher/project_files'])
call denite#custom#source(
\ 'file/rec', 'matchers', ['matcher/fuzzy'])
" Change sorters.
call denite#custom#source(
\ 'file/rec', 'sorters', ['sorter/rank'])
" \ 'file/rec', 'sorters', ['sorter/sublime'])


" Change default action.
" call denite#custom#kind('file', 'default_action', 'split')


"    let g:unite_source_grep_command='/usr/local/bin/rg'
"    " unite seems to require this opts field start with a space.  or, maybe a
"    " double --.  but using "-terminal=false" makes it misinterpret the output
"    " extending the file name until the end of line and adding a ':0' as the line
"    " number at the end.  weird.
"    let g:unite_source_grep_default_opts='--hidden --no-heading --vimgrep -S'
"    let g:unite_source_grep_recursive_opt=''
" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
                \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" make all denite sources start in insert mode
call denite#custom#option("_", "start_filter", 1)
call denite#custom#option("_", "direction", "dynamictop")

"    function! s:unite_settings()
"      hi PmenuSel guifg=White
"      nmap <buffer> Q <plug>(unite_exit)
"      nmap <buffer> <esc> <plug>(unite_exit)
"      "imap <buffer> <esc> <plug>(unite_exit)
"    endfunction
"    autocmd FileType unite call s:unite_settings()

nmap <space> [denite]
nnoremap [denite] <nop>

if has('win32') || has('win64')
  nnoremap <silent> [denite]<space> :<C-u>Denite -toggle -auto-resize -buffer-name=mixed file/rec buffer file_mru bookmark<cr><c-u>
  nnoremap <silent> [denite]f :<C-u>Denite -toggle -auto-resize -buffer-name=files file/rec<cr><c-u>
else
  nnoremap <silent> [denite]<space> :<C-u>Denite -toggle -auto-resize -buffer-name=mixed file/rec buffer file_mru bookmark<cr><c-u>
  " ! arg to file/rec/async means start from project directory (defined by
  " having .git dir)
  nnoremap <silent> [denite]f :<C-u>Denite -auto-resize -buffer-name=files file/rec file/rec/test<cr><c-u>
endif
nnoremap <silent> [denite]y :<C-u>Denite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [denite]l :<C-u>Denite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [denite]b :<C-u>Denite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [denite]/ :<C-u>Denite  -buffer-name=search grep:.<cr>
nnoremap <silent> [denite]G :<C-u>DeniteWithCursorWord -buffer-name=search grep:.<cr>
nnoremap <silent> [denite]m :<C-u>Denite -auto-resize -buffer-name=mappings mapping<cr>
nnoremap <silent> [denite]s :<C-u>Denite -quick-match buffer<cr>
nnoremap <silent> [denite]r :<C-u>DeniteResume<cr>
nnoremap <silent> [denite]q :<C-u>Denite quickfix<cr>
nnoremap <silent> [denite]L :<C-u>Denite location_list<cr>

"    " unite settings
"    
"    " goal is to have unite respect .gitignore file
"    " from https://coderwall.com/p/pwh5jg/ignoring-gitignore-files-in-unite-vim
"    let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
"    
"    call unite#filters#matcher_default#use(['matcher_fuzzy'])
"    call unite#filters#sorter_default#use(['sorter_rank'])
"    " call unite#set_profile('files', 'smartcase', 1)
"    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
"    call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)
"    
"    let g:unite_data_directory='~/.vim/.cache/unite'
"    let g:unite_enable_start_insert=1
"    let g:unite_source_history_yank_enable=1
"    let g:unite_source_rec_max_cache_files=10000
"    let g:unite_source_grep_max_candidates=1000
"    let g:unite_prompt='» '
"    
"    "let g:unite_source_grep_command='ack-grep'
"    "let g:unite_source_grep_default_opts='--no-heading --no-color '
"    "let g:unite_source_grep_recursive_opt=''
"    let g:unite_source_grep_command='/usr/local/bin/rg'
"    " unite seems to require this opts field start with a space.  or, maybe a
"    " double --.  but using "-terminal=false" makes it misinterpret the output
"    " extending the file name until the end of line and adding a ':0' as the line
"    " number at the end.  weird.
"    let g:unite_source_grep_default_opts='--hidden --no-heading --vimgrep -S'
"    let g:unite_source_grep_recursive_opt=''
"    
"    function! s:unite_settings()
"      hi PmenuSel guifg=White
"      nmap <buffer> Q <plug>(unite_exit)
"      nmap <buffer> <esc> <plug>(unite_exit)
"      "imap <buffer> <esc> <plug>(unite_exit)
"    endfunction
"    autocmd FileType unite call s:unite_settings()
"    
"    nmap <space> [unite]
"    nnoremap [unite] <nop>
"    
"    if has('win32') || has('win64')
"      nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec buffer file_mru bookmark<cr><c-u>
"      nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec<cr><c-u>
"    else
"      nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr><c-u>
"      " ! arg to file_rec/async means start from project directory (defined by
"      " having .git dir)
"      nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
"    endif
"    nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
"    nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
"    nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
"    nnoremap <silent> [unite]/ :<C-u>Unite  -buffer-name=search grep:.<cr>
"    nnoremap <silent> [unite]G :<C-u>UniteWithCursorWord -buffer-name=search grep:.<cr>
"    nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
"    nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
"    nnoremap <silent> [unite]r :<C-u>UniteResume<cr>
"    nnoremap <silent> [unite]q :<C-u>Unite quickfix<cr>
"    nnoremap <silent> [unite]L :<C-u>Unite location_list<cr>



"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist
set autoread    " automatically re-read buffers if changed on disk

"mapping for command key to map navigation thru display lines instead
"of just numbered lines
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

"statusline setup
set statusline=%f       "tail of the filename

"Git
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
" set statusline+=[%{GitBranch()}]

"RVM
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.class "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:\ \ ,extends:>,precedes:<
" disabling list because it interferes with soft wrap

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

set background=light
colorscheme PaperColor

"some stuff to get the mouse going in term
if !has('nvim')
    set mouse=a
    set ttymouse=xterm2
endif

"hide buffers when not displayed
set hidden


silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
"nnoremap <silent> <C-f> :call FindInNERDTree()<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

"map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
"nnoremap Y y$

"bindings for ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

" do not mark syntax errors with :signs
let g:syntastic_enable_signs=0

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

call camelcasemotion#CreateMotionMappings('<leader>')

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"key mapping for saving file
nmap <C-s> :w<CR>

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'}

"Enabling Zencoding
let g:user_zen_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \  'erb' : {
  \    'extends' : 'html',
  \  },
 \}

"make Ctrl-C work as copy in visual mode
vnoremap <C-c> "+y
vnoremap <S-Insert> "+y

" increase max # files for command-t
let g:CommandTMaxFiles=30000

" Disable pylint checking every save
let g:pymode_lint_write = 0
" Disable pymode whitespace trimming
let g:pymode_utils_whitespaces = 0

" :DiffOrig to diff current buffer with its saved file version
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

autocmd FileType java setlocal shiftwidth=4 tabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$' " note: requires space after first and before last | of prev/next line
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
filetype plugin indent on
syntax on
autocmd FileType go setlocal autoindent noexpandtab shiftwidth=4 tabstop=4

" LaTeX - don't highlight underscores in red, like errors
let g:tex_no_error=1
let g:Tex_UseMakefile='pdflatex'

au BufRead, BufNewFile *.m2 so $HOME/.vim/m2.vimrc
