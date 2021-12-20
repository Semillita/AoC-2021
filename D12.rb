require "set"
lines = File.open("Input12.txt").readlines.map(&:chomp)

def getPaths(caves, visited, cave, visTwice)
    if cave == "end"
        return 1
    end
    visited.add(cave)

    sum = 0
    for c in caves[cave]
        if visTwice
            if ( !visited.include?(c) ) || ("A".."Z").to_a.include?(c[0])
                sum += getPaths(caves, visited.clone, c, true)
            end
        else
            if ( !visited.include?(c) ) || ("A".."Z").to_a.include?(c[0])
                sum += getPaths(caves, visited.clone, c, false)
            end
            if visited.include?(c) && !("A".."Z").to_a.include?(c[0]) && (c != "start")
                sum += getPaths(caves, visited.clone, c, true)
            end
        end
    end
    return sum
end

upc = {}
loc = {}
caves = {}

for line in lines
    cave1, cave2 = line.split(/\-/)
    if caves.key?(cave1)
        caves[cave1].push(cave2)
    else
        caves[cave1] = [cave2]
    end

    if caves.key?(cave2)
        caves[cave2].push(cave1)
    else
        caves[cave2] = [cave1]
    end
end

puts getPaths(caves, Set.new, "start", false)