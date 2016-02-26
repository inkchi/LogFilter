require 'kconv'

# IoOperation
class IoOperation
  def self.files(file_path)
    file = Dir.glob(file_path)
    file.empty? ? IOError.new : file
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.dir_file] #{e}"
    exit 1
  end

  def self.lines(file_name)
    File.open(file_name, 'r:utf-8') do |file|
      file.each_line.each_with_object([]) { |line, a| a.push(line.chop.toutf8) }
    end
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.lines] #{e}"
    exit 1
  end

  def self.write(result) # TODO Hash前提の作りになっている
    File.open("#{Time.now.strftime('%Y%m%d')}_search.txt", 'w') do |file|
      result.each do |key, value|
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

  def self.delete_file(file_names)
    File.unlink(*file_names)
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.delete_file] #{e}"
    exit 1
  end
end
