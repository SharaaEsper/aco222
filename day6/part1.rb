#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input = line
end

cursor = 0
input.split('').each do |cha|
  if cursor < 3
    cursor += 1
    next
  end
  if input[cursor -3..cursor].split('').uniq.count == 4
    break
  end
  cursor += 1
end

puts cursor + 1