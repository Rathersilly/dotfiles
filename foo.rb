file = 'keys.txt'

lines = []
File.open(file, 'r') do |f|
  lines = f.readlines
end
p lines
lines.each do |line|
  line.gsub!(/.*keymap/,'')
end
pp lines
