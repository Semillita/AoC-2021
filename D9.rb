require "set"

$lines = File.open("Input9.txt").readlines.map{|line| line.chomp}

def findSteep(y, x, acc)
    acc.add([y, x])
    num = $lines[y][x].to_i
    
    [[y, x-1], [y, x+1], [y-1, x], [y+1, x]]
        .filter{|y1, x1| y1 >= 0 && y1 < $lines.length && x1 >= 0 && x1 < $lines[0].length && 
            !acc.include?([y1, x1]) && $lines[y1][x1].to_i > num && $lines[y1][x1].to_i != 9}
        .each{|y1, x1| acc += findSteep(y1, x1, acc)}
    return acc
end

basins = []

sum = 0
for x in 0...$lines[0].length
    for y in 0...$lines.length
        num = $lines[y][x].to_i
        isLow = true

        dirs = [[y, x-1], [y, x+1], [y-1, x], [y+1, x]]
            .filter{|y1, x1| y1 >= 0 && y1 < $lines.length && x1 >= 0 && x1 < $lines[0].length}
            .map{|y1, x1| $lines[y1][x1].to_i <= num}

        if dirs.all?(false)
            sum += (1 + num)
            steeps = findSteep(y, x, Set.new).length
            basins.push(steeps)
        end
    end
end

puts sum
puts basins.sort.last(3).inject(:*)