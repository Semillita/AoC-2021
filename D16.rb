$bits = []
$total = 0
File.open("Input16.txt").read.strip.chars.each do |char|
    b = char.to_i(16).to_s(2).chars
    for i in 0...(4-b.length)
        b.insert(0, "0")
    end
    $bits += b
end

def package(start, level)
    version = (0..2).to_a.map{|num| $bits[start + num]}.join.to_i(2)
    typeID = (3..5).to_a.map{|num| $bits[start + num]}.join.to_i(2)
    lengthID = $bits[start + 6]
    sum = 0
    length = 6
    i = 6
    case typeID
    when 4
        str = ""
        look = true
        while look
            i += 5
            length += 5
            if $bits[start + i - 5] == "0"
                look = false
            end
            for x in 1..4
                str += $bits[start + i + x - 5]
            end
        end

        sum = str.to_i(2)
    else
        vals = []
        case lengthID
        when "0"
            bitLength = (7..21).to_a.map{|num| $bits[start + num]}.join.to_i(2)
            length = 6 + 1 + 15 + bitLength
            i = 0
            while i <= bitLength - 11
                val, len = package(start + i + 7 + 15, level + 1)
                i += len

                vals.push(val)
            end
        when "1"
            amount = (7..17).to_a.map{|num| $bits[start + num]}.join.to_i(2)
            i = 0
            amount.times do 
                val, len = package(start + i + 7 + 11, level + 1)
                i += len

                vals.push(val)
            end
            length = i + 18
        end
        case typeID
        when 0
            sum = vals.sum
        when 1
            sum = vals.inject(:*)
        when 2
            sum = vals.min
        when 3
            sum = vals.max
        when 5
            sum = (vals[0] > vals[1]) ? 1 : 0
        when 6
            sum = (vals[0] < vals[1]) ? 1 : 0
        when 7
            sum = (vals[0] == vals[1]) ? 1 : 0
        end
    end
    $total += version
    return [sum, length]
end
ans2 = package(0, 1)[0]
puts $total
puts ans2