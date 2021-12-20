require "set"

groups = File.open("Input14.txt").read.split(/\n\n/)
template = "z" + groups[0] + "z"
rules = groups[1].split(/\n/).map{|rule| rule.split(" -> ")}.to_h

pairs = {}

def solve(steps)
    template.chars.each_cons(2){|first, second| pairs[first + second] = pairs[first + second].to_i + 1} 

    for i in 1..steps
        newPairs = {}
        pairs.each do |pair, occ|
            if pair.include?("z")
                newPairs[pair] = 1
                next
            end
            ins = rules[pair]
            pair1 = pair[0] + rules[pair]
            pair2 = rules[pair] + pair[1]
            if newPairs.key?(pair1)
                newPairs[pair1] += occ
            else
                newPairs[pair1] = occ
            end
    
            if newPairs.key?(pair2)
                newPairs[pair2] += occ
            else
                newPairs[pair2] = occ
            end
        end
        pairs = newPairs
    end
    
    charOcc = {}
    pairs.each do |pair, occ|
        first = pair[0]
        second = pair[1]
        for char in [first, second]
            if charOcc.key?(char)
                charOcc[char] += occ
            else
                charOcc[char] = occ
            end
        end
    end
    
    max = charOcc.values.max
    min = nil
    for val in charOcc.values
        if (min == nil || val < min) && val != 0 && val != 2
            min = val
        end
    end
end


puts max / 2 - min / 2