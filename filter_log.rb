# filter_log
class FilterLog
  def self.run(rules, lines)
    search(union_regexp(rules), convert_hash(lines))
  rescue => e
    STDERR.puts "[ERROR][#{self.class.name}.run] #{e}"
    exit 1
  end

  def self.union_regexp(rules)
    tm = rules.each_with_object([]) do |x, y|
      next if x.empty?
      y.push(x)
    end
    Regexp.union(tm)
  end

  def self.convert_hash(lines)
    lines
      .each_with_index
      .each_with_object([]) { |(val, i), arr| arr.push([i + 1, val]) }
      .to_h
  end

  def self.search(regexp, lines)
    lines.select { |_, v| v.match(regexp) }
  end

  private_class_method :union_regexp
  private_class_method :convert_hash
  private_class_method :search
end
