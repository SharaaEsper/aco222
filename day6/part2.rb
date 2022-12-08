#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input = line
end

cursor = 0
input.split('').each do |cha|
  if cursor < 13
    cursor += 1
    next
  end
  if input[cursor -13..cursor].split('').uniq.count == 14
    break
  end
  cursor += 1
end

puts cursor + 1