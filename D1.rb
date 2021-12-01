lines = File.open("Input1.txt").readlines.map{|line| line.to_i}

answer1 = (1...lines.length).to_a
    .filter{|index| lines[index] > lines[index - 1]}
    .length

groups = (0...lines.length - 2).to_a
    .map{|index| lines[index] + lines[index + 1] + lines[index + 2]}

answer2 = (1...groups.length).to_a
    .filter{|index| groups[index] > groups[index - 1]}
    .length

puts answer1
puts answer2