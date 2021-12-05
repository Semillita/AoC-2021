lines = File.open("Input2.txt").readlines

x1 = 0
y1 = 0

x2 = 0
y2 = 0
aim = 0

for line in lines
    case line
    when /forward (\d+)/
        x1 += $1.to_i
        x2 += $1.to_i
        y2 += $1.to_i * aim
    when /up (\d+)/
        y1 -= $1.to_i
        aim -= $1.to_i
    when /down (\d+)/
        y1 += $1.to_i
        aim += $1.to_i
    end
end

puts "Part 1: #{x1*y1}"
puts "Part 2: #{x2*y2}"