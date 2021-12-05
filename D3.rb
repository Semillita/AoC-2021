lines = File.open("Input3.txt").readlines.map{|line| line.chomp.chars}
columns = lines.transpose

#Part 1
gam = ""
eps = ""
for col in columns
    gam += (col.count("1") > col.count("0")) ? "1" : "0"
    eps += (col.count("1") > col.count("0")) ? "0" : "1"
end
puts "Part 1: #{gam.to_i(2) * eps.to_i(2)}"

#Part 2
oxg = lines.clone
co2 = lines.clone

for x in 0...columns.length
    oxgCols = oxg.transpose
    co2Cols = co2.transpose

    common1 = (oxgCols[x].count("1") >= oxgCols[x].count("0")) ? "1" : "0"
    common2 = (co2Cols[x].count("1") < co2Cols[x].count("0")) ? "1" : "0"

    oxg = (oxg.length == 1) ? oxg : oxg
    .filter{|line| line[x] == common1}

    co2 = (co2.length == 1) ? co2 : co2
        .filter{|line| line[x] == common2}
end
puts "Part 2: #{oxg[0].join.to_i(2) * co2[0].join.to_i(2)}"