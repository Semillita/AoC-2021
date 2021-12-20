algorithm, inputImage = File.open("Input20.txt").read.split(/\n\n/)
    .map{|group| group.gsub(".", "0").gsub("#", "1")}
        # .map{|line| line.gsub(".", "0").gsub("#", "1")}}

algorithm = algorithm.gsub("\n", "")

def neighbors(y, x)
    return [[y-1, x-1], [y-1, x], [y-1, x+1], [y, x-1], [y, x], [y, x+1], [y+1, x-1], [y+1, x], [y+1, x+1]]
end

def createOutputImage(inputImage, algorithm, rest)
    # puts "takes in rest #{rest}"
    outputImage = []
    for y in -1...(inputImage.length+1)
        row = ""
        for x in -1...(inputImage[0].length+1)
            target = ""
            neighbors = neighbors(y, x)
            # p neighbors
            # puts "x: #{x}, y: #{y}"
            for n in neighbors
                if n[0] >= 0 && n[0] < inputImage.length && n[1] >= 0 && n[1] < inputImage[0].length
                    if y == -1 && x == -1
                        # puts "Add origin"
                        # puts inputImage[n[0]][n[1]]
                    end
                    target += inputImage[n[0]][n[1]]
                    r = inputImage[n[0]]
                    # puts "r length: #{r.length}"
                    # puts "r: #{r}"
                    # puts n[0]
                    # puts n[1]
                    # puts r[n[1]]
                else
                    if y == -1 && x == -1
                        # puts "Add rest"
                    end
                    target += rest
                end
                if y == -1 && x == -1
                    # puts "New target: #{target}"
                end
            end
            index = target.to_i(2)
            # puts index
            # puts "---"
            # puts target
            row += algorithm[index].to_s

            if y == -1 && x == -1
                # puts "-1, -1 set to #{algorithm[index]} with target #{target}"
                # p algorithm
            end 
        end
        outputImage.push(row)
    end
    restI = ""
    (1..9).to_a.each{|time| restI += rest}
    restI = restI.to_i(2)
    rest = algorithm[restI]
    return outputImage, rest
end

image = inputImage.split(/\n/)
rest = "0"

# puts "Original image"
for row in image
    # puts row.gsub("0", ".").gsub("1", "#")
end

for i in 1..50
    # puts "i: #{i}"
    image, rest = createOutputImage(image, algorithm, rest)
    # puts "New image:"
    for row in image
        # puts row.gsub("0", ".").gsub("1", "#")
    end
    # puts "New rest:"
    # p rest
end

count = 0
for row in image
    for cell in row.chars
        if cell == "1"
            count += 1
        end
    end
end
puts count

# for row in image
#     puts row.gsub("0", ".").gsub("1", "#")
# end