"NeoBundle
"----------------------------------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible 
  endif "
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

"環境系
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \ 'windows' : 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac' : 'make -f make_mac.mak',
  \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

"Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

"Snippet
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

"Tree
NeoBundle 'scrooloose/nerdtree'

"基本機能拡張
NeoBundle 'Townk/vim-autoclose'

call neobundle#end()

filetype plugin indent on
filetype indent on

NeoBundleCheck

"NERDTree
"----------------------------------------------------------
" キーマップ
nnoremap ,n :NERDTree<CR>
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
 
" デフォルトでツリーを表示させる
"autocmd VimEnter * execute 'NERDTree'



"unite
"----------------------------------------------------------
" インサートモードで起動
let g:unite_enable_start_insert = 1
" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	" 単語単位からパス単位で削除するように変更
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	" ESCキーを2回押すと終了する
	nmap <silent><buffer> <ESC><ESC> q
	imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

" Railsに特化したマッピング
nnoremap <silent> ,f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> ,fm :<C-u>Unite  file_mru <CR>
nnoremap <silent> ,uc :<C-u>Unite file file/new -input=app/controllers/ <CR>
nnoremap <silent> ,um :<C-u>Unite file file/new -input=app/models/ <CR>
nnoremap <silent> ,uv :<C-u>Unite file file/new -input=app/views/ <CR>
nnoremap <silent> ,us :<C-u>Unite file file/new -input=app/assets/stylesheets/ <CR>
nnoremap <silent> ,uj :<C-u>Unite file file/new -input=app/assets/javascripts/ <CR>
nnoremap <silent> ,uo :<C-u>Unite file file/new -input=config/ <CR>
nnoremap <silent> ,ul :<C-u>Unite file file/new -input=lib/ <CR>
nnoremap <silent> ,ur :<C-u>Unite file file/new -input=./ <CR>




"neocomplcacheの設定
"----------------------------------------------------------
"補完ウィンドウの設定
set completeopt=menuone

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" ディクショナリ定義
let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'php' : $HOME . '/.vim/dict/PHP.dict',
			\ 'ctp' : $HOME . '/.vim/dict/PHP.dict'
			\ }

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"<TAB>でスニペット補完
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" 前回行われた補完をキャンセルします
inoremap <expr><C-g> neocomplcache#undo_completion()

"補完候補のなかから、共通する部分を補完します
inoremap <expr><C-l> neocomplcache#complete_common_string()

" 改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

" 現在選択している候補を確定します
inoremap <expr><C-y> neocomplcache#close_popup()

"現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()



"基本設定
"----------------------------------------------------------
" 改行コードの自動認識
set fileformats=unix,dos,mac

" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

" ノーマルモードでもエンターキーで改行を挿入
noremap <CR> o<ESC>

"バックアップファイル自動作成の停止
set nobackup




" 検索関係
"----------------------------------------------------------

" コマンド、検索パターンを100個まで履歴に残す
set history=100

" 検索の時に大文字小文字を区別しない
"set ignorecase

" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase

" 最後まで検索したら先頭に戻る
set wrapscan

" インクリメンタルサーチを使わない
set noincsearch







" 表示関連
"----------------------------------------------------------

" 行番号を表示する
set number

" 入力中のコマンドをステータスに表示する
set showcmd

" ステータスラインを常に表示
set laststatus=2

" 括弧入力時の対応する括弧を表示
set showmatch

" 対応する括弧の表示時間を2にする
set matchtime=2

" 検索結果文字列のハイライトを有効にする
set hlsearch

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" 入力中のコマンドステータスに表示する
set showcmd

" カラースキーマの設定
colorscheme dw_green
syntax on





" インデント
"----------------------------------------------------

" オートインデントを有効にする
set autoindent

" タブが対応する空白の数
set tabstop=2

" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2

" インデントの各段階に使われる空白の数
set shiftwidth=2

" タブを挿入するとき、代わりに空白を使う
set expandtab

" ヤンクした文字は、システムのクリップボードに入れる"
set clipboard+=unnamed




" map
"----------------------------------------------------------

let maplocalleader = ','

nnoremap ,sp :sp<CR>
nnoremap ,vp :vsp<CR>
nnoremap ,t :tabnew<CR>
nnoremap ,g gt
nnoremap ,a gT
nnoremap ,q :q<CR>
nnoremap <C-j> <C-d>
" nnoremap <C-k> <C-u>
nnoremap <silent> ,j <C-W>j
nnoremap <silent> ,k <C-W>k
nnoremap <silent> ,h <C-W>h
nnoremap <silent> ,l <C-W>l

" 表示行単位で行移動するようにする
nnoremap j gj
nnoremap k gk

" esc２回で検索ハイライトを消す
nnoremap <ESC><ESC> :nohl<CR>


" その他
"----------------------------------------------------
"ビジュアルモード時vで行末まで選択
vnoremap v $h

" ,vrでvimの設定ファイルを開く
nnoremap ,vr :e ~/.vimrc<CR>

" ,eでexploreを起動
nnoremap ,e :Explore<CR>
