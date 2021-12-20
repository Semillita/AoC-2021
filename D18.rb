lines = File.open("Input18.txt").readlines.map(&:chomp)

def parseLine(line)
    return eval(line.gsub(/(\w+?)/, "\\1"))
end

def deepArrayCopy(arr)
    layer = []
    for element in arr
        if element.class != Array
            layer.push(element)
        else
            layer.push(deepArrayCopy(element))
        end
    end
    return layer
end

def regularNumbers(num, indices)
    if num.class == Integer
        return [[num, indices]]
    end
    map = []
    for index in 0..1
        element = num[index]
        newIndices = indices.clone
        newIndices.push(index)
        map += regularNumbers(element, newIndices)
    end
    return map
end

def firstPair(pair1, pair2)
    # puts "Comparing #{pair1} and #{pair2}"
    for index in 0...[pair1.length, pair2.length].min
        if pair1[index] < pair2[index]
            return pair1
        elsif pair2[index] < pair1[index]
            return pair2
        end
    end
    return pair1
end

def pointer(line, indices)
    # puts "Finding pointer for indices #{indices} in:"
    # p line
    pointer = line
    for index in indices
        pointer = pointer[index]
        # puts "--#{pointer}--"
    end
    return pointer
end

def findIndex(regulars, indices)
    # puts "Finding index with #{indices}"
    for index in 0...regulars.length
        # p regulars[index][1]
        if regulars[index][1] == indices
            # puts "Index: #{index}"
            return index
        end
    end
end

def explode(line, regulars, indices)
    # puts "Explode pair #{indices}"
    pair = pointer(line, indices)
    leftValIndices = indices + [0]
    # p leftValIndices
    rightValIndices = indices + [1]
    # p rightValIndicess

    leftRegIndex = findIndex(regulars, leftValIndices)
    if leftRegIndex > 0
        val = regulars[leftRegIndex][0]
        # puts "Left has val: #{val}"
        leftTargetIndex = leftRegIndex - 1
        leftTargetIndices = regulars[leftTargetIndex][1]
        # puts "leftTargetIndices: #{leftTargetIndices}"
        leftPairIndices = leftTargetIndices.first(leftTargetIndices.length - 1)
        # puts "leftPairIndices: #{leftPairIndices}"
        leftPairPointer = pointer(line, leftPairIndices)
        # puts "leftPairPointer: #{leftPairPointer}"
        leftPairPointer[leftTargetIndices.last] += val
    end

    rightRegIndex = findIndex(regulars, rightValIndices)
    if rightRegIndex < (regulars.length - 1)
        val = regulars[rightRegIndex][0]
        # puts "Right has val: #{val}"
        rightTargetIndex = rightRegIndex + 1
        rightTargetIndices = regulars[rightTargetIndex][1]
        # puts "rightTargetIndices: #{rightTargetIndices}"
        rightPairIndices = rightTargetIndices.first(rightTargetIndices.length - 1)
        # puts "rightPairIndices: #{rightPairIndices}"
        rightPairPointer = pointer(line, rightPairIndices)
        # puts "rightPairPointer: #{rightPairPointer}"
        rightPairPointer[rightTargetIndices.last] += val
    end
end

def split(line, regulars, indices)
    # puts "Split num #{indices}"
    val = pointer(line, indices) / 2.to_f
    # puts "Val: #{val}"
    valLeft = val.floor
    valRight = val.ceil
    parentPointer = pointer(line, indices.first(indices.length - 1))
    parentPointer[indices.last] = [valLeft, valRight]

end

def reduce(line)

    loop do
        # puts "-----Running loop-----"
        # puts "Line: #{line}"
        regulars = regularNumbers(line, [])
        explode = nil
        split = nil;

        for reg in regulars
            if reg[1].length >= 5
                # puts "Nested in 4: #{reg[1]}"
                parent = reg[1].first(reg[1].length - 1)
                # p parent
                if explode == nil
                    explode = parent
                else
                    explode = firstPair(parent, explode)
                end
            end
    
            if reg[0] >= 10
                if split == nil
                    split = reg[1]
                else
                    split = firstPair(reg[1], split)
                end
            end
        end

        # if explode != nil && split == nil
        #     # Explode
        # elsif explode != nil && explode = firstPair(explode, split.first(split.length - 1))
        #     # Explode
        # elsif split != nil && explode == nil
        #     # Split
        # elsif split != nil && split = firstPair(explode, split.first(split.length - 1))
        #     # Split
        # end

        if explode != nil
            explode(line, regulars, explode)
            parentPointer = pointer(line, explode.first(explode.length-1))
            # puts "Parent indices: #{explode.first(explode.length-1)}"
            # puts "parentPointer: #{parentPointer}"
            # puts "line: #{line}"
            parentPointer[explode.last] = 0
            # puts "parentPointer after: #{parentPointer}"
            # puts "line: #{line}"
        elsif split != nil
            split(line, regulars, split)
        else
            # puts "No action"
        end

        # p explode
        # p split

        break if explode == nil && split == nil

        # sleep(0.5)
    end
end

def mag(parent, indices)
    # sleep(0.3)
    sum = 0

    child1 = parent[0]
    if child1.class == Integer
        sum += 3 * child1
    else
        sum += 3 * mag(child1, indices + [0])
    end
    
    child2 = parent[1]
    if child2.class == Integer
        sum += 2 * child2
    else
        sum += 2 * mag(child2, indices + [1])
    end

    return sum
end

def solve(lines)
    lines = lines.map{|line| parseLine(line)}
    max = 0
    for first in lines
        for second in lines.clone-[first]
            whole = [deepArrayCopy(first), deepArrayCopy(second)]
            reduce(whole)
            m = mag(whole, [])
            if m > max
                max = m
            end
        end
    end

    puts max
    # max = 0
    # firstQueue = lines.clone
    # secondQueue = lines.clone
    # for first in firstQueue
    #     fp = parseLine(first)
    #     for second in secondQueue-[first.clone]
    #         sp = parseLine(second)
    #         whole = [fp.clone, sp.clone]
    #         reduce(whole.clone)
    #         m = mag(whole, [])
    #         if m > max
    #             max = m
    #             puts "----------"
    #             p first
    #             p fp
    #             p second
    #             p sp
    #         end
    #     end
    # end

    # puts max


    # for first in lines.clone
    #     fc = first.clone
    #     firstParsed = parseLine(first)
    #     if first != fc
    #         puts "AAAAAAAA"
    #     end
    #     sAlt = lines.clone
    #     sAlt.delete(first)
    #     for second in sAlt
    #         fp = firstParsed.clone.to_s
    #         secondParsed = parseLine(second)
    #         sp = secondParsed.clone.to_s
    #         whole = [firstParsed, secondParsed]
    #         reduce(whole)
    #         mag = mag(whole, [])
    #         if mag > max
    #             max = mag
    #             puts "--------------"
    #             puts first
    #             p fp
    #             puts second
    #             p sp
    #             puts mag
    #         end
    #     end
    # end

    # puts max
end

solve(lines)