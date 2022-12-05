#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end

elves = [[0, []]]
index = 0
input.each do |elf|
  if elf =~ /^\s+$/
    index += 1
    elves[index] = [0, []]
  else
    elves[index][0] += elf.to_i
    elves[index][1] << elf.to_i
  end
end

puts elves.sort.last[0]