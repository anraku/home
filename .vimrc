"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=2 "インデントをスペース2つ分に設定
set shiftwidth=2  " 自動インデントでずれる幅
set smartindent "オートインデント
set cursorline " カーソル行の背景色を変える

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"#####ショートカットキー設定#####
"htmlからjavascript連結文字列に変換
vmap <silent> ;h :s?^\(\s*\)+ '\([^]\+\)',*\s*$?\1\2?g<CR>
"javascript連結文字列からhtmlへ変換
vmap <silent> ;q :s?^\(\s*\)\(.*\)\s*$? \1 + '\2'?<CR>

