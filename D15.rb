require "set"
require "rubygems"
require "algorithms"
require 'containers/priority_queue'

def neighbors(pos, inputLength)
    row, col = pos
    return [[row-1, col], [row+1, col], [row, col-1], [row, col+1]]
        .filter{|y, x| x >= 0 && x < inputLength && y >= 0 && y < inputLength}
end

def solve(input)
    dist = {}
    for r in 0...input.length
        for c in 0...input.length
            dist[[r, c]] = 1e12.to_i
        end
    end
    dist[[0, 0]] = 0

    prev = {}
    explored = Set.new
    queue = Containers::PriorityQueue.new
    queue.push([0, 0], 0)
    while !queue.empty?
        pos = queue.pop
        explored.add(pos)
        neighbors = neighbors(pos, input.length)
        for n in neighbors
            alt = input[n[0]][n[1]] + dist[pos]
            if alt < dist[n]
                dist[n] = alt
                prev[n] = pos
                if  !explored.include?(n)
                    queue.push(n, -dist[n])
                end
            end
        end
    end
    return dist[[input.length-1, input.length-1]]
end

input = File.open("Input15.txt").readlines.map{|line| line.strip.chars.map(&:to_i)}

input2 = []
for r in 0...input.length*5
    newRow = []
    for c in 0...input.length*5
        inputVal = input[r % input.length][c % input.length]
        increase = (r / input.length).to_i + (c / input.length).to_i
        val = (inputVal + increase - 1) % 9 + 1
        newRow.push(val)
    end
    input2.push(newRow)
end

puts solve(input)
puts solve(input2)