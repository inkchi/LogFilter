******
Log_filterの使い方
******

■使い方：
①filterフォルダにフィルタ条件ファイルを格納
②workフォルダに検索対象ファイルを格納
③log_filter.rbをダブルクリック
④検索結果ファイル「YYYYDDMM_result.txt」が作成される

■検索結果ファイル
****
./work/(検索ファイル名)
****
該当行数 -> 該当文

詳細は「(sample)20160222_search.txt」参照

■ディレクトリ構成：

/--+--fileter/ -> フィルタ条件ファイルを格納(複数可)
   |      |
   |      +--filter1
   |      +--filter2       
   |
   +--work/    -> 検索対象ファイルを格納(複数可)
   |      |
   |      +--file1
   |      +--file2
   |
   +--log_filter.rb -> 検索実行ファイル
   |
   +--(YYYYDDMM_search.txt) -> 実行結果ファイル
   |
   +--README.txt -> 本ファイル

■システム要件：
ruby -> 2.2.3 # その他verで動くかは未検証

