" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/dein')
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
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0}) 

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"#####プラグイン設定#####
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" ファイルオープンを便利に
Plug 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
Plug 'Shougo/neomru.vim'
" ファイルをtree表示してくれる
Plug 'scrooloose/nerdtree'
call plug#end()

"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース2つ分に設定
set shiftwidth=2  " 自動インデントでずれる幅
set smartindent "オートインデント
set cursorline " カーソル行の背景色を変える
set backspace=indent,eol,start "バックスペースが効かなくなる事象に対しての対応策

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"#####ショートカットキー設定#####
"htmlからjavascript連結文字列に変換
vmap <silent> ;h :s?^\(\s*\)+ '\([^]\+\)',*\s*$?\1\2?g<CR>
"javascript連結文字列からhtmlへ変換
vmap <silent> ;q :s?^\(\s*\)\(.*\)\s*$? \1 + '\2'?<CR>

"###プラグイン設定###
"NEARDTree
let g:NERDTreeShowBookmarks=1
map <C-t> :NERDTreeToggle<CR>

"###uniteの設定###
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>

"行番号の色を変更
highlight LineNr ctermfg=239

"#####コマンド設定#####
"" インサートモードの時に C-j でノーマルモードに戻る
imap <C-j> <esc>

" ２回esc を押したら検索のハイライトをヤメる
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"#####マウス設定#####
" マウス使えます
set mouse=a
"NeoBundleの設定(begin)
" neobundle settings {{{
"if has('vim_starting')
"  set nocompatible
"  " neobundle をインストールしていない場合は自動インストール
"	  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
"	    echo "install neobundle..."
"	    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
"	    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
"	  endif
"	  " runtimepath の追加は必須
"	  set runtimepath+=~/.vim/bundle/neobundle.vim/
"	endif
"	call neobundle#begin(expand('~/.vim/bundle'))
"	let g:neobundle_default_git_protocol='https'
"	
"	" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
"	NeoBundleFetch 'Shougo/neobundle.vim'
"	" ↓こんな感じが基本の書き方
"	NeoBundle 'nanotech/jellybeans.vim'
"	NeoBundle 'fatih/vim-go'
"	
"	" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
"	NeoBundleCheck
"	call neobundle#end()
filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256

" --- vimのタブに関する設定 ---
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
" --- vimのタブに関する設定 ---
set background=dark
"colorscheme hybrid
