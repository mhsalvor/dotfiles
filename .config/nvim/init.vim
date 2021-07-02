"
"    _       _ _         _
"   (_)     (_) |       (_)
"    _ _ __  _| |___   ___ _ __ ___
"   | | '_ \| | __\ \ / / | '_ ` _ \
"   | | | | | | |_ \ V /| | | | | | |
"   |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
"   ~/.config/nvim/init.vim
"   Neovim configuration file.
"
" Wrtitten to work on *most* GNU/Linux distributions.
" Things not working or WIP are commented out. Unless I forgot.
" Much of what follows has been 'stolen' from many places over the years and
" tweaked to suit my workflow and personal preferences; feel free to do the same.
"
" Remember, like with all of my work, I am only able to provide the following
" assurance(s):
" It is almost certainly going to work until it breaks; although I have to
" admit it may never work and that would be sad.
" When/if it does break, you may keep all of the pieces.
" If you find my materials helpful, both you & I will be happy, at least for a
" little while.
" My advice is worth every penny you paid for it!
"
" by:
" Giuseppe (mhsalvor) Molinaro
" g.molinaro@linuxmail.org
" https://githup.com/mhsalvor
"""

"=== Leader keys ==="
"
" <space> is a common choice for <leader>, and an easy key to hit.
" But, since I'm using an Italian QWERTY keyboard, I have a few keys that no
" default config files written for standard QUWERTY will ever use.
" You should consider changing theese.
let mapleader="ò"       " map <leader>
let maplocalleader="à"  " map <localLeader>

"=== Vim-Plug - Plugin Manager ==="

" The following code will check for vim-plug. If it's not present in your system
" it will set it up and all of your plugins with it.
" Useful on new installation when all you need to restore your settings is
" this one file.
" Credits: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

"--- Main
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !mkdir -p ~/.local/share/nvim/bundle
    silent !mkdir -p ~/.local/share/nvim/undo
    silent !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"--- Plugin list and Installation.
" All Plugins must appear between plug#begin() and plug#end()
call plug#begin('~/.local/share/nvim/bundle')
" Required for :help vim-plug
Plug 'junegunn/vim-plug'

" Themes
Plug 'vim-airline/vim-airline'          " AirLine status bar
Plug 'vim-airline/vim-airline-themes'   " AirLine themes
Plug 'sainnhe/sonokai'                  " sonokai/maia theme

" Quality of life
Plug 'terryma/vim-multiple-cursors'                         " Multi-cursor
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}     " Async color preview
Plug 'tpope/vim-surround'                                   " Change surrounding symbols
"Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'                                  " show indentations

" Compilers
Plug 'tpope/vim-dispatch'                   " Ascyncronous compiler dispatch
    Plug 'radenling/vim-dispatch-neovim'    " Add support for neovim's terminal emulator and job control to dispatch.vim
Plug 'aliev/vim-python'                     " Python compiler

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc-vim
Plug 'tpope/vim-commentary'                         " commenting
Plug 'tmsvg/pear-tree'                              " Parenteses and other symbols pair completion

" Syntax hightliting
Plug 'sheerun/vim-polyglot'             " A collection of language packs.
Plug 'baskerville/vim-sxhkdrc'          " Simple X Hotkey Daemon config file
Plug 'mboughaba/i3config.vim'           " i3 configuration file
Plug 'vim-python/python-syntax'         " better Python support
Plug 'Vimjas/vim-python-pep8-indent'    " Python PEP8 indentation
"Plug 'frazrepo/vim-rainbow'    " display parenteses with colors depending on levels

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Files search, navigation and manipulation
Plug 'tpope/vim-apathy'                             " path settings for some common languages (instead of path+=**)
Plug 'junegunn/fzf.vim'                             " fuzzy file finder
Plug 'preservim/nerdtree'                           " NERDTree - a tree explorer plugin for vim
    Plug 'Xuyuanp/nerdtree-git-plugin'              " git support for NERDTree
    Plug 'ryanoasis/vim-devicons'                   " enables devicons - needs to be After NERDTree-git
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  " syntax highlight for NERDTree
"Plug 'francoiscabrol/ranger.vim'                   " Ranger integration

" Git
"Plug 'jreybert/vimagit'                            " Magit-like plugin for vim
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()

"=== Basic configuration and Defaults ==="

set title                       " use filename in windowtitle
set undofile                    " persistent undo
set mouse=a                     " enable mouse support (should work by default in nvim but...)
set clipboard+=unnamedplus      " use the system clipboard for copy-paste
set wildmode=list:longest,full  " Adjust autocompletion behavior
set noshowmode                  " don't show mode info below the statusline, only show them once
set termguicolors               " make nvim use truecolors
set lazyredraw                  " don't redraw when you don't have to
set magic                       " enable extended regExp
set noerrorbells                " disable error bells
set visualbell                  " use the visual bell for the rest
set nojoinspaces                " Instert only 1 space after '.' '?' and '!' with a join command
set ofu=syntaxcomplete#Complete " Set omni-completion method
set report=0                    " Show all changes
set noeol                       " Don’t add empty newlines at the end of files
set completeopt=longest,menuone,preview     " make completion menu behave more like an IDE

" Python
let g:python_highlight_all = 1

" Lisp
set lispwords+=defroutes                                " Compojure
set lispwords+=defpartial,defpage                       " Noir core
set lispwords+=defaction,deffilter,defview,defsection   " Ciste core
set lispwords+=describe,it                              " Speclj TDD/BDD

"=== Key mappings ==="
"-------- Mapping Legends {{{
"------------------------------------------------------
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
"
" nunmap - Unmap a normal mode map
" vunmap - Unmap a visual and select mode map
" xunmap - Unmap a visual mode map
" sunmap - Unmap a select mode map
" iunmap - Unmap an insert and replace mode map
" cunmap - Unmap a command-line mode map
" ounmap - Unmap an operator pending mode map
"
" mapclear  - Clear all normal, visual, select and operating pending mode maps
" mapclear! - Clear all insert and command-line mode maps
" nmapclear - Clear all normal mode maps
" vmapclear - Clear all visual and select mode maps
" xmapclear - Clear all visual mode maps
" smapclear - Clear all select mode maps
" imapclear - Clear all insert mode maps
" cmapclear - Clear all command-line mode maps
" omapclear - Clear all operating pending mode maps
"
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" xmap, xnoremap, xunmap          Visual mode
" smap, snoremap, sunmap          Select mode
" cmap, cnoremap, cunmap          Command-line mode
" omap, onoremap, ounmap          Operator pending mode

" Remap ESC to èè in INSERT mode
" as with the leader keys, I am taking full advantage of my non english
" keyboard
imap èè <Esc>

" Create multiple newlines in NORMAL mode
nnoremap <S-o> O<Esc>
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>j

" Better split navigation Alt+hjkl
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Make adjusing split sizes a bit more friendly  Alt+ arrowkeyes
noremap <silent> <A-Left> :vertical resize +3<CR>
noremap <silent> <A-Right> :vertical resize -3<CR>
noremap <silent> <A-Up> :resize +3<CR>
noremap <silent> <A-Down> :resize -3<CR>

" Alias write and quit
nnoremap <leader>q :wq<CR>
nnoremap <leader>w :w<CR>

" Remap spellcheck key
" [s move to previous mispelled word
" ]s move to next mispelled word
" zg > adds good word to personal dictionary
" zw > marks word as incorrect
" z= > show suggestions; difficult on italian keyboards
nnoremap zl z=

" Open terminal inside neovim
map <leader>t :vnew term://bash<Cr>

" Save file as sudo when no sudo permissions
cmap w!! w !sudo tee > /dev/null %

" Copy and paste
" copy to both the clipboard and primary selectio
vnoremap <C-c> "*y : let @+=@*<CR>
" paste where the cursor is
map <C-p> "+P
" Make Y behave like other commands
nnoremap <silent> Y y$

" Spell check 'o' as in orthography
map <F5> :setlocal spell! spelllang=it,en_us,en_gb<CR>

" Replace All is aliased to S
nnoremap S :%s//g<left><left>

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler <c-r>%<CR>

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" Shell check
map <leader>p :!clear && shellcheck %<CR>

"=== General Appearances and Quality of Life ==="

"--- AirLine Statusbar
let g:airline_powerline_fonts = 1                   " enable powerline symbols
"let g:airline_symbols.dirty='⚡'

let g:airline#extensions#wordcounts#enabled = 1     " GitGutter integration
let g:airline#extensions#hunks#non_zero_only =1
let g:airline_theme = 'sonokai'                     " use sonokai theme

"--- Theme - Sonokai Maia
let g:sonokai_style = 'maia'                    " select the style for sonokai
let g:sonokai_enable_italic = 0                 " toggle italic keywords
let g:sonokai_disable_italic_comment = 0        " toggle italic for comments
let g:sonokai_transparent_background = 0        " toggle transparent background
let g:sonokai_sign_column_background = 'none'   " set the background for signcolumn
let g:sonokai_better_performance = 1            " reduce loading times
colorscheme sonokai

"--- Interface tweaking
set hidden                  " hide when switching buffers, don't unload
set colorcolumn=80,120      " show a line on column 80 and 120
set scrolloff=5             " Always show 5 lines above and below the cursor
set number                  " enable line numbers
set relativenumber          " make them relative to current line
set splitbelow splitright   " adjust were splits go
set cursorline              " highlight cursor line
set cursorcolumn            " highlight cursor column
set nohlsearch              " turn off permanent highlighting of search results
set list
set listchars=tab:▸·,nbsp:␣,trail:·
set showbreak=↪
set showmatch               " show bracket matches

"--- Indentation
set autoindent              " enable autoindent
set smartindent             " do smart auto indent when starting a new line

"--- Improved searches
set ignorecase  " case insensitive searching
set smartcase   " override ignorecase if upper case is typed
set path+=**    " search current directory recursively

"--- Text tweaks
" 1 TAB == 4 Spaces
set expandtab       " use spaces instead of tabs
set shiftwidth=4    " spaces when auto indenting
set softtabstop=4   " spaces for <Tab> and <BS>
set tabstop=4       " size of the TAB character, 8 is the legacy safe value.

" Indent and tab options for specific file types.
autocmd FileType c,make setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8


"--- Wrapping
set nowrap          " disable line wrap
set linebreak       " When wrapping, do only so at a certain character

"--- Folding
" folding hotkeys
" S-v zf while in visual line mode create fold
" C-v zf while is visual block mode create fold
" zf#j   creates a fold from the cursor down numbers of lines.
" zf/    string creates a fold from the cursor to string .
" za     When on a closed fold, open it.and vice-versa.
" zA     When on a closed fold, open it recursively.and vice-versa
" zj     moves the cursor to the next fold.
" zk     moves the cursor to the previous fold.
" zo     opens a fold at the cursor.
" zO     opens all folds at the cursor.
" zm     increases the foldlevel by one.
" zM     closes all open folds.
" zr     decreases the foldlevel by one.
" zR     decreases the foldlevel to zero -- all folds will be open.
" zd     deletes the fold at the cursor.
" zE     deletes all folds.
" [z     move to start of open fold.
" ]z     move to end of open fold.
set foldcolumn=0        " column to show folds
set foldenable          " enable folding
set foldlevelstart=1    " folding on a newly opened file
set foldlevel=1         " default foldlevel to 1 to see headings
"set foldignore=         " don't ignore anything when folding. USE ONLY w/ foldmethod=indent
"set foldmethod=indent   " collapse using indentation
set foldmethod=syntax   " collapse using syntax
"set foldmethod=marker   " collapse using markers, defaults are {{{,}}}
set foldminlines=0      " allow folding single lines
set foldnestmax=5       " set mazx fold nesting level

"--- Automatic formatting
" default is tcqj
" t autowrap text using textwidth
" c autowrap comments using textwidth, insert the current comment leader automatically
" q allow formatting of comments with gg (indentations and such)
" j when it makes sense, remove a comment leader when joining lines
set formatoptions+=r    " Automatically insert the current comment leader after hitting <Enter> in Insert mode
set formatoptions+=n    " when formatting text, recognize numbered lists
set formatoptions+=2    " when formatting text, use the indent form the second line as defauls, instead of the first one. Works in comments
set formatoptions+=l    " Don't breack lines that are alredy past textwidth
set formatoptions+=1    " don't breack lines after 1 letter words
set iskeyword-=.        " Make '.' end of word designator
set iskeyword-=#        " Make '#' end of word designator

"--- Custom spellings
set spellfile=~/.config/nvim/techspeak.utf-8.add,~/.config/nvim/mywords.utf-8.add

"--- Colors and Highlighting
" Same color for sign column and line numbers
highlight clear SignColumn

" Custom spell-checking highlighting
highlight SpellBad     cterm=underline  term=underline  gui=underline
highlight SpellCap     cterm=underline  term=underline  gui=underline
highlight SpellRare    cterm=underline  term=underline  gui=underline
highlight SpellLocal   cterm=underline  term=underline  gui=underline

" Tab line
highlight TabLine      cterm=NONE  ctermfg=33   ctermbg=235  guifg=#268bd2  guibg=#073642
highlight TabLineFill  cterm=NONE  ctermfg=33   ctermbg=235  guifg=#268bd2  guibg=#073642
highlight TabLineSel   cterm=NONE  ctermfg=235  ctermbg=33   guifg=#073642  guibg=#268bd2

"=== Basic AutoCmd ==="

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

"=== Plugin specific configuration ==="

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC -- Edit With extreme CARE                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"  prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" let g:coc_global_extensions = [
"             \ 'coc-snippets',
"             \ 'coc-pairs',
"             \ 'coc-tsserver',
"             \ 'coc-html',
"             \ 'coc-css',
"             \ 'coc-prettier',
"             \ 'coc-json',
"             \ 'coc-angular',
"             \ 'coc-vimtex'
"             \ ]

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D to show documentation in preview window.
" nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mycocgroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to foldcurrent buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--- pear-tree
" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'}
            \ }
" See pear-tree/after/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default:
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 60

" Automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys = 1

" Default mappings:
imap <BS> <Plug>(PearTreeBackspace)
imap <CR> <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)
" Pear Tree also makes <Plug> mappings for each opening and closing string.
"     :help <Plug>(PearTreeOpener)
"     :help <Plug>(PearTreeCloser)

" Not mapped by default:
" <Plug>(PearTreeSpace)
" <Plug>(PearTreeJump)
" <Plug>(PearTreeExpandOne)
" <Plug>(PearTreeJNR)

"--- syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_phpcs_disable = 1
let g:syntastic_phpmd_disable = 1
let g:syntastic_php_checkers = ['php']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"--- Vim fzf
" Searches git repositories
nnoremap <A-g> :GFiles<CR>
command! -bang -nargs=? -complete=dir GFiles
            \call fzf#vim#gfiles(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)
" Searches filesystem
nnoremap <A-z> :Files<CR>
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)
" Preview windows preferences
let g:fzf_preview_window = 'right:60%'  "split right, 60% size of main split

"--- Nerdtree
" Open NerdTree automatically on nvim startup
"autocmd vimenter * NERDTree
" Close nvim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree
map <C-f> :NERDTreeToggle<Cr>

" Settings
let NERDTreeMinimalUI = 0                   " use a minimalist UI if 1, hides ? help
"let g:NERDTreeDirArrowExpandable = '►'
"let g:NERDTreeDirArrowCollapsible = '▼'
let g:NERDTreeShowLineNumber=1              " show line numbers in NerdTree slpit
let g:NERDTreeShowHidden=1                  " show hidden files
let g:NERDTreeWinSize=38                    " Split size


"" nerdtree-git-plugin
" use nerdfonts
let g:NERDTreeGitStatusUseNerdFonts = 1     " you should install nerdfonts!

"--- vim-hexokinase
"" Update when leaving Insert Mode
let g:Hexokinase_refreshEvents = ['TextChangedI', 'TextChanged', 'InsertLeave']
"" What formats to highlight
" let g:Hexokinase_optInPatterns = [
            " \ 'full_hex',
            " \ 'triple_hex',
            " \ 'rgb',
            " \ 'rgba',
            " \ 'hsl',
            " \ 'hsla',
            " \ 'colour_names'
            " \]
"" Use the full background theme
let g:Hexokinase_highlighters = ['backgroundfull']
"" Enable hexokinase on enter
autocmd VimEnter * HexokinaseTurnOn

"--- GitGutter
" some colors
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0            " disable default mappings
let g:gitgutter_highlight_linenrs = 1
"----end gitgutter

"--- Goyo
map <leader>f :Goyo set linebreak<CR>
" Enable Goyo by default for mutt writting
" Goyo's width will be the line limit in mutt.
autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

"--- Indentline
"let g:indentLine_setColors = 0     " Use the colorscheme colors
let g:indentLine_char = '·'
"let g:indentLine_setConceal = 0    " don't change conceal settings

"=== Filetype specific options ==="

"--- Fix some filetype detections
"set g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" let g:vimwiki_list = [{'path': '~/Documenti/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.config/calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

"--- Enable spellcheking when needed
autocmd FileType tex,latex,markdown setlocal spell spelllang=it,en_us,en_gb

"--- Mutt
autocmd BufRead,BufNewFile ~/.mutt/tmp/* set filetype=mail | set textwidth=80 | set spell |  set wrap | setlocal spell spelllang=it,en_us,en_gb

"--- TeX and LaTeX
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
"   autocmd VimLeave *.tex !texclear %
" Word count:
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
" Code snippets
autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ,li <Enter>\item<Space>
autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,bt {\blindtext}
autocmd FileType tex inoremap ,nu $\varnothing$
autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

"--- html
autocmd FileType html inoremap ,b <b></b><Space><++><Esc>FbT>i
autocmd FileType html inoremap ,it <em></em><Space><++><Esc>FeT>i
autocmd FileType html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
autocmd FileType html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
autocmd FileType html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
autocmd FileType html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
autocmd FileType html inoremap ,li <Esc>o<li></li><Esc>F>a
autocmd FileType html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
autocmd FileType html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
autocmd FileType html inoremap ,td <td></td><++><Esc>Fdcit
autocmd FileType html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
autocmd FileType html inoremap ,th <th></th><++><Esc>Fhcit
autocmd FileType html inoremap ,tab <table><Enter></table><Esc>O
autocmd FileType html inoremap ,gr <font color="green"></font><Esc>F>a
autocmd FileType html inoremap ,rd <font color="red"></font><Esc>F>a
autocmd FileType html inoremap ,yl <font color="yellow"></font><Esc>F>a
autocmd FileType html inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
autocmd FileType html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
autocmd FileType html inoremap &<space> &amp;<space>
autocmd FileType html inoremap á &aacute;
autocmd FileType html inoremap é &eacute;
autocmd FileType html inoremap í &iacute;
autocmd FileType html inoremap ó &oacute;
autocmd FileType html inoremap ú &uacute;
autocmd FileType html inoremap ä &auml;
autocmd FileType html inoremap ë &euml;
autocmd FileType html inoremap ï &iuml;
autocmd FileType html inoremap ö &ouml;
autocmd FileType html inoremap ü &uuml;
autocmd FileType html inoremap ã &atilde;
autocmd FileType html inoremap ẽ &etilde;
autocmd FileType html inoremap ĩ &itilde;
autocmd FileType html inoremap õ &otilde;
autocmd FileType html inoremap ũ &utilde;
autocmd FileType html inoremap ñ &ntilde;
autocmd FileType html inoremap à &agrave;
autocmd FileType html inoremap è &egrave;
autocmd FileType html inoremap ì &igrave;
autocmd FileType html inoremap ò &ograve;
autocmd FileType html inoremap ù &ugrave;

"--- .bib
autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"--- Markdown
autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

"--- .xml
autocmd FileType xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
autocmd FileType xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"

"--- Configuration Files

" Edit Vim config file in a new tab.
map <Leader>ev :tabnew $MYVIMRC<CR>
" Source Vim config file.
map <Leader>sv :source $MYVIMRC<CR>

" sxhkdrc
" Update binds when sxhkdrc is updated.
"autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Xdefaults - Xresources
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

"""EOF""" vim: ft=vim
