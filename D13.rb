require "set"

groups = File.open("Input13.txt").read.split(/\n\n/)
paper = groups[0].split(/\n/).map(&:chomp).map{|point| point.split(/,/).map(&:to_i)}.to_set
folds = groups[1].split(/\n/)
for index in 0...folds.length
    fold = folds[index]
    newPaper = Set.new
    case fold
    when /fold along y=(\d+)/
        for point in paper
            if point[1] > $1.to_i
                newPaper.add([point[0], $1.to_i - (point[1] - $1.to_i)])
            elsif point[1] < $1.to_i 
                newPaper.add(point)end
        end
    when /fold along x=(\d+)/
        for point in paper
            if point[0] > $1.to_i
                newPaper.add([$1.to_i - (point[0] - $1.to_i), point[1]])
            elsif point[0] < $1.to_i 
                newPaper.add(point)
            end
        end
    end
    paper = newPaper
    if index == 0
        puts paper.length
    end
end

image = (0..paper.map{|x, y| y}.max).to_a
    .map{|row| (0..paper.map{|x, y| x}.max).to_a
        .map{|cell| " "}}

for point in paper
    image[point[1]][point[0]] = "#"
end

image.each{|row| puts row.join}