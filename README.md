# LogFilter
## About 'LogFilter'
複数の検索条件ファイル(/.txt|.log/) × 複数の検索対象ファイル(/.txt|.log/)  
でのフィルタリングを行います。
検索実行結果は、.txt形式で出力されます。
## index
* Outline of processing
* How to use
* System requirements

## Outline of processing
1. ./filter内のファイルを全て読み込み、改行(\n)区切りで保存
1. (1)をOR条件とし検索条件を作成
1. ./work内のファイル1つ読み込み、改行(\n)区切りで保存
1. (2)の検索条件でフィルタリング
1. ヒットする文字列が存在すれば、「YYYYMMDD_search.txt」に行数とともに書き込み
1. (3)~(5)を./work配下を全て処理するまで繰り返す


## How to use
1. filterフォルダにフィルタ条件ファイルを格納(複数ファイル可)
2. workフォルダに検索対象ファイルを格納(複数ファイル可)
3. log_filter.rbをダブルクリック
4. 検索結果ファイル「YYYYDDMM_result.txt」が作成される

## System requirements
ruby >= 2.2.3
\* 上記ver以外で実行できるかは未検証