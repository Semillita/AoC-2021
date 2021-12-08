require "set"

lines = File.open("Input8.txt").readlines

#Part 1
count =  0

for line in lines
    for token in line.split(/ \| /)[1].split()
        if token.length == 2 || token.length == 4 || token.length == 3 || token.length == 7
            count += 1
        end
    end
end

puts count

#Part 2
sum = 0

for line in lines
    words = line.split(/ \| /)[0].split

    one = words.find{|word| word.length == 2}
    seven = words.find{|word| word.length == 3}
    four = words.find{|word| word.length == 4}
    six = words.find{|word| word.length == 6 && (word.chars - one.chars).length == 5}
    five = words.find{|word| word.length == 5 && (word.chars - six.chars).length == 0}
    three = words.find{|word| word.length == 5 && (word.chars - seven.chars).length == 2}
    two = words.find{|word| word.length == 5 && word != three && word != five}
    eight = words.find{|word| word.length == 7}
    nine = words.find{|word| word.length == 6 && (three.chars - word.chars).length == 0}
    zero = words.find{|word| word.length == 6 && word != six && word != nine}

    wordToDigit = {one.chars.sort => 1, two.chars.sort => 2, three.chars.sort => 3, four.chars.sort => 4, five.chars.sort => 5, 
        six.chars.sort => 6, seven.chars.sort => 7, eight.chars.sort => 8, nine.chars.sort => 9, zero.chars.sort => 0}

    sum += line.split(/ \| /)[1].split.map{|word| wordToDigit[word.chars.sort]}.join.to_i
end

puts sum