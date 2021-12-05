require "set"
groups = File.open("Input4.txt").read.split(/\n\n/)
drawOrder = groups.shift.split(/,/).map(&:to_i)
boards = groups
    .map{|group| group.split(/\n/)
        .map{|line| line.split
            .map(&:to_i)}}

$drawn = Set.new

bingo = lambda {|board| board
    .any?{|row| row.all?{|square| $drawn.include?(square)}} || 
    board.transpose.any?{|column| column.all?{|square| $drawn.include?(square)}}}

bingoBoards = Set.new

for num in drawOrder
    $drawn.add(num)

    if bingoBoards.length < boards.length
        for i in (0...boards.length)
            if bingo.(boards[i])
                if bingoBoards.empty?
                    print "Part 1: "
                    puts boards[i].flatten
                    .filter{|square| !$drawn.include?(square)}
                    .sum * num
                end

                bingoBoards.add(boards[i])

                if bingoBoards.length == boards.length
                    print "Part 2: "
                    puts boards[i].flatten
                    .filter{|square| !$drawn.include?(square)}
                    .sum * num
                    break
                end
            end
        end
    end
end