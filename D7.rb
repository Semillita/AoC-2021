input = File.open("Input7.txt").read.split(/,/).map(&:to_i)

puts (input.min..input.max).to_a
    .map{|pos| input
        .map{|num| (num - pos).abs}.sum}
    .min

stepCosts = (0..(input.max - input.min)).to_a
    .map{|dist| (0..dist).to_a.sum}

puts (input.min..input.max).to_a
    .map{|pos| input
        .map{|num| stepCosts[(num - pos).abs]}
        .sum}
    .min