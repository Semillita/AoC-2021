lines = File.open("Input5.txt").readlines
    .map{|line| line.match(/(\d+),(\d+) -> (\d+),(\d+)/).captures.map(&:to_i)}

diagram = {}

lines.filter{|x1, y1, x2, y2| x1 == x2 || y1 == y2}
    .each do |x1, y1, x2, y2|
        for x in ([x1, x2].min..[x1, x2].max).to_a
            for y in ([y1, y2].min..[y1, y2].max).to_a
                if diagram.key?([x, y])
                    diagram[[x, y]] += 1
                else
                    diagram[[x, y]] = 1
                end
            end
        end
    end

print "Part 1: "
puts diagram
    .filter{|pos, val| val > 1}
    .length

lines.filter{|x1, y1, x2, y2| (x1 - x2).abs == (y1 - y2).abs}
    .each do |x1, y1, x2, y2|
        for inc in (0..(x1 - x2).abs).to_a
            x = (x1 < x2) ? x1 + inc : x1 - inc
            y = (y1 < y2) ? y1 + inc : y1 - inc
            if diagram.key?([x, y])
                diagram[[x, y]] += 1
            else
                diagram[[x, y]] = 1
            end
        end
    end

print "Part 2: "
puts diagram
    .filter{|pos, val| val > 1}
    .length