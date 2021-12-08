input = File.open("Input6.txt").readlines[0].split(/,/).map(&:to_i)

for x in [80, 256]
    dayNew = (0..(x+9)).to_a
        .map{|x| [x, input.count(x - 1)]}.to_h

    puts input.length + (0..x)
        .each{|day| dayNew[day+7], dayNew[day+9] = dayNew[day+7] + dayNew[day], dayNew[day+9] + dayNew[day]}
        .map{|day| dayNew[day]}
        .sum
end