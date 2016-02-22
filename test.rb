arr = ["a", "b", "c", "", "e"]
res = arr.each_with_object([]) do |x, a|
  next if x.empty?
  a.push(x)
end
p res