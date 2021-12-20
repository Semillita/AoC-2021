$tX1, $tX2, $tY1, $tY2 = File.open("Input17.txt").read.chomp.gsub("target area: ", "")
    .split(", ")
    .map{|section| section.gsub(/.=/, "").split("..")}
    .flatten
    .map(&:to_i)

def solve(xVel, yVel)
    smallerX = (0 < $tX1)
    smallerY = (0 < $tY1)
    yPositions = []

    xPos = 0
    yPos = 0

    target = false
    while true

        xPos += xVel
        yPos += yVel
        xVel += (xVel > 0) ? -1 : (xVel < 0) ? 1 : 0
        yVel -= 1
        yPositions.push(yPos)

        if xPos >= $tX1 && xPos <= $tX2 && yPos >= $tY1 && yPos <= $tY2
            target = true
        end

        if (smallerX && xPos > $tX2) || (!smallerX && xPos < $tX1) || (smallerY && yPos > $tY2) || (!smallerY && yPos < $tY1)
            break
        end
    end
    return target ? yPositions.max : nil
end

max = 0
count = 0

for xVel in 1..275
    for yVel in (-100)..250
        val = solve(xVel, yVel)
        if val != nil 
            count += 1
            if val > max 
                max = val
            end
        end
    end
end

puts max
puts count