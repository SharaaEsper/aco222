#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end

x_pos = 0
y_pos = 0
forest = Hash.new
#0,0 is bottom left so we gotta flip it on its head. 
input.reverse.each do |line|
  x_pos = 0
  line.strip.split("").each do |cha|
    forest["#{x_pos},#{y_pos}"] = cha
    x_pos += 1
  end
  y_pos += 1
end

#This sets the largest x/y so we don't try to find trees in nil-land. 
y_limit = forest.keys.select { |s| s.match(/^0,\d+/) }[-1].gsub(/\d+,/, '').strip.to_i
x_limit = forest.keys.select { |s| s.match(/^\d+,0/) }[-1].gsub(/,\d+/, '').strip.to_i

#Biggest Tree is 9. 
tall_boi = 9

scenic_trees = Array.new
0.upto(x_limit) do |x_pos|
  0.upto(y_limit) do |y_pos|
    if x_pos == 0 || y_pos == 0 || x_pos == x_limit || y_pos == y_limit
      #Edges will have a 0 multi, so they aren't eligible. 
    else
      left_multi = 0
      right_multi = 0
      down_multi = 0
      up_multi = 0
      #To the left
      (x_pos -1).downto(0) do |x_pos_scan|
        left_multi += 1
        if forest["#{x_pos_scan},#{y_pos}"] >= forest["#{x_pos},#{y_pos}"]          
          break
        end        
      end

      #To the right
      (x_pos +1).upto(x_limit) do |x_pos_scan|
        right_multi += 1
        if forest["#{x_pos_scan},#{y_pos}"] >= forest["#{x_pos},#{y_pos}"]
          break
        end
      end

      #To the...down
      (y_pos -1).downto(0) do |y_pos_scan|
        down_multi += 1
        if forest["#{x_pos},#{y_pos_scan}"] >= forest["#{x_pos},#{y_pos}"]
          break
        end
      end

      #And up.
      (y_pos +1).upto(y_limit) do |y_pos_scan|
        up_multi += 1
        if forest["#{x_pos},#{y_pos_scan}"] >= forest["#{x_pos},#{y_pos}"]
          break
        end
      end
      scenic_trees << left_multi * right_multi * up_multi * down_multi
    end
  end
end

puts scenic_trees.sort[-1]