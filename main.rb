require_relative 'filter_log'
require_relative 'io_operation'

WORK_DIR = './work/*'.freeze
FILTER_DIR = './filter/*'.freeze

# 正規表現を取得
regexp_rules = IoOperation.files(FILTER_DIR).each_with_object([]) do |file, arr|
  arr.push(IoOperation.lines(file))
end.flatten

puts '===regexp_rules==='
puts regexp_rules

# 検索実行
hit_results = IoOperation.files(WORK_DIR).each_with_object(Hash.new(0)) do |file, h|
  h[file.to_s] = FilterLog.run(regexp_rules, IoOperation.lines(file))
end

# 結果書き出し
puts '===hit_results==='
puts hit_results
IoOperation.write(hit_results) # TODO:Hashでしか書き込めない
# io.delete_file([io.dir_file(FILTER), io.dir_file(WORKDIR)].flatten)