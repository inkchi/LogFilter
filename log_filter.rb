WORKDIR = './work/*'.freeze
FILTER  = './filter/*'.freeze

# test

# filter_log
class FilterLog
  def initialize
    @regexp = nil
    @text = nil
  end

  def run(rule, text)
    make_regexp(rule)
    make_text(text)
    search
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.run] #{e}"
    exit 1
  end

  private

  def make_regexp(rule)
    tm = rule.each_with_object([]) do |x, y|
      next if x.empty?
      y.push(x)
    end
    p @regexp = Regexp.union(tm)
  end

  def make_text(text)
    @text = text
      .each_with_index
      .each_with_object([]) { |(val, i), arr| arr.push([i + 1, val]) }
      .to_h
  end

  def search
    @text.select { |_, v| v.match(@regexp) }
  end
end

# IoOperation
class IoOperation
  require 'kconv'
  def dir_file(path)
    file = Dir.glob(path)
    file.size == 0 ? IOError.new : file
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.dir_file] #{e}"
    exit 1
  end

  def file_open(path)
    arr = File.open(path, 'r:utf-8') do |file|
      file.each_line.each_with_object([]) { |line, a| a.push(line.chop.toutf8) }
    end
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.file_open] #{e}"
    exit 1
  end

  def write(res)
    File.open("#{Time.now.strftime('%Y%m%d')}_search.txt", 'w') do |file|
      res.each do |key, value|
        file.puts '*****'
        file.puts key
        file.puts '*****'
        value.each { |k, v| file.puts "#{k} -> #{v}" }
        file.puts ''
      end
    end
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.write] #{e}"
    exit 1
  end

  def delete_file(file_names)
    File.unlink(*file_names)
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.delete_file] #{e}"
    exit 1
  end
end

def main
  fl = FilterLog.new
  io = IoOperation.new

  rule = io.dir_file(FILTER).each_with_object([]) do |x, arr|
    arr.push(io.file_open(x))
  end.flatten

  log_name = io.dir_file(WORKDIR)
  res = log_name.each_with_object(Hash.new(0)) do |s, h|
    h[s.to_s] = fl.run(rule, io.file_open(s))
  end
  p res
  io.write(res)
  # io.delete_file([io.dir_file(FILTER), io.dir_file(WORKDIR)].flatten)
end

main
