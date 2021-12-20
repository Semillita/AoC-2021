require "set"

def createScanners
    scanners = File.open("Input19.txt").read.split(/\n\n/)
        .map{|scanner| scanner.split(/\n/)}
        .map{|scanner| scanner.last(scanner.length - 1)
            .map{|coords| coords.split(/,/).map(&:to_i)}}
    return [scanners.first.to_set, scanners.last(scanners.length - 1)]
end

def createDirections
    rotation = [[0, 1], [1, 1], [2, 1], [0, -1], [1, -1], [2, -1]]
    directions = []
    for x in rotation
        for y in rotation - [x]
            for z in rotation - [x, y]
                directions.push([x, y, z])
            end
        end
    end
    return directions
end

def applyRotation(dir, relativeBeacons)
    rotatedBeacons = []
    for b in relativeBeacons
        rotatedBeacons.push([
            dir[0][1]*b[dir[0][0]],
            dir[1][1]*b[dir[1][0]],
            dir[2][1]*b[dir[2][0]]
        ])
    end
    return rotatedBeacons
end

def getDist(first, second)
    return [first[0] - second[0], first[1] - second[1], first[2] - second[2]]
end

def findMatch(absoluteBeacons, relativeBeacons, dirs)
    for dir in dirs
        rotatedBeacons = applyRotation(dir, relativeBeacons)
        dist = {}
        for first in absoluteBeacons
            for second in rotatedBeacons
                d = getDist(first, second)
                dist[d] = dist[d].to_i + 1
            end
        end
        for d, amount in dist
            if amount >= 12
                translatedBeacons = Set.new
                for beacon in rotatedBeacons
                    translatedBeacons.add([beacon[0]+d[0], beacon[1]+d[1], beacon[2]+d[2]])
                end
                return true, d, translatedBeacons
            end
        end
    end
    return false, nil, nil
end

def solve()
    absoluteBeacons, scanners = createScanners()
    dirs = createDirections()
    positions = [[0, 0, 0]]

    while !scanners.empty?
        s2 = []
        # scanners.each_with_index do |relativeBeacons, index|
        for relativeBeacons in scanners
            works, scannerPos, translatedBeacons = findMatch(absoluteBeacons, relativeBeacons, dirs)
            if works
                absoluteBeacons |= translatedBeacons
                positions.push(scannerPos)
            else
                s2.push(relativeBeacons)
            end
        end
        scanners = s2
    end

    most = 0
    for first in positions
        for second in positions
            distance = (first[0] - second[0]).abs + (first[1] - second[1]).abs + (first[2] - second[2]).abs
            most = [most, distance].max
        end
    end
    for position in positions
        p position
    end
    return [absoluteBeacons.length, most]
end

part1, part2 = solve()
puts part1
puts part2