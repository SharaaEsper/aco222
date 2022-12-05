#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end

cursor = 1
line_num = 0
warehouse = Hash.new
input.each do |line|
  line.split('').each do |cha|
    if cha =~ /\[|\]|\d|\s/
    else
      if warehouse[(cursor + 2) / 4].nil?
        warehouse[(cursor + 2) / 4] = Array.new
      end
      warehouse[(cursor + 2) / 4] << cha
    end
    cursor += 1
  end
  cursor = 1
  line_num += 1
  if line =~ /^$/
    warehouse.each do |key, array|
      warehouse[key] = array.reverse
    end
    warehouse = warehouse.sort_by { |key| key }.to_h
    break
  end
end

input[line_num..-1].each do |line|
  instruction = line.split
  1.upto(instruction[1].to_i) do |s|
    warehouse[instruction[5].to_i] << warehouse[instruction[3].to_i].pop
  end
  warehouse[instruction[5].to_i] = warehouse[instruction[5].to_i].flatten
end
answer = String.new
warehouse.each do |key, arr|
  answer += arr[-1]
end

puts answer