set cindent
map <silent> <C-n> :NERDTreeToggle<CR>


"dein以外の設定
set nu
set mouse =a
syntax  on
set cursorline

set clipboard+=unnamedplus "clipboardとヤンクの連携

set foldmethod=indent  "インデントで折りたたむ
"set foldlevel=5
set foldcolumn=2

" Save fold settings.
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options

set termguicolors    " ターミナルでも True Color を使えるようにする。
set pumblend=10      " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。

" 以下はおまけ。ここでは Denite の設定を載せていますが、
" 同様の仕組みで任意のウィンドウを半透明化できるでしょう。
augroup transparent-windows
  autocmd!
  autocmd FileType denite set winblend=10  " こちらも 5 〜 30 で試してみてください。
  autocmd FileType denite-filter set winblend=10
augroup END
set wildoptions=pum

colorscheme iceberg

if has('persistent_undo')
	let undo_path = expand('~/.config/nvim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

set tabstop =2
set shiftwidth =2
set title

set fileencodings=ucs-bombs,utf-8,euc-jp,cp932

set noswapfile "swapをつくらない
set hidden

set visualbell

set ignorecase  "大文字小文字を無視
set smartcase

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

nnoremap <Esc><Esc> :noh<CR>

"インサートモードのままカーソル移動
inoremap <C-f> <C-g>U<Right>
inoremap <C-f><C-f> <C-g>U<ESC><S-a>


if has('vim_starting')
    " 挿入モード時に非点滅の縦
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅
    let &t_EI .= "\e[2 q"
  	let &t_SR .= "\e[4 q"
endif

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-j> :bp<CR>
nnoremap <silent> <C-k> :bn<CR>



"dein のせってい　
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.config/nvim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})


  " 設定終了
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
