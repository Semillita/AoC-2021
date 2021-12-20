require "set"
map = File.open("Input11.txt").readlines.map{|line| line.chomp.chars.map{|char| char.to_i}}

def flash(map, inc, flashed, x, y)
    flashed.add([y, x])
    map[y][x] = 0
    for xx in [x-1, 0].max..[x+1, map[0].length - 1].min
        for yy in [y-1, 0].max..[y+1, map.length - 1].min
            if xx != x || yy != y
                inc[[yy, xx]] += 1
                if map[yy][xx] + inc[[yy, xx]] > 9
                    if !flashed.include?([yy, xx])
                        flash(map, inc, flashed, xx, yy)
                    end
                end
            end
        end
    end
end

totalFlashes = 0
running = true
i = 0

while running
    i += 1

    flashed = Set.new
    inc = {}
    for y in 0...map.length
        for x in 0...map[0].length
            map[y][x] += 1
            inc[[y, x]] = 0
        end
    end

    for y in 0...map.length
        for x in 0...map[0].length
            if map[y][x] > 9
                flash(map, inc, flashed, x, y)
            end
        end
    end

    inc.each do |k, v|
        if !flashed.include?(k)
            map[k[0]][k[1]] += v
        end
    end

    totalFlashes += flashed.length

    if flashed.length == map.length * map[0].length
        running = false
        ans = i
    end
end

puts totalFlashes
puts ans