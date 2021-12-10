lines = File.open("Input10.txt").readlines.map{|line| line.chomp}

points1 = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
points2 = {"(" => 1, "[" => 2, "{" => 3, "<" => 4}

errorScore = 0
completeScores = []
for line in lines
    while line.match(/\(\)|\[\]|\{\}|\<\>/)
        line = line.split(/\(\)|\[\]|\{\}|\<\>/).join
    end
    
    if line.chars.any?{|char| char.match(/\)|\]|\}|\>/)}
        errorScore += line.chars.filter{|char| char.match(/\)|\]|\}|\>/)}.map{|char| points1[char]}.first
    else
        completeScores.push(line.reverse.chars.inject(0){|sum, char| sum * 5 + points2[char]})
    end
end

puts errorScore
puts completeScores.sort[(completeScores.length / 2).to_i]