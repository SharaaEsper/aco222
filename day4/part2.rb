#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end


dumb_elf = 0
elf1 = Array.new
elf2 = Array.new
input.each do |entry|
  elves = entry.split(',')
  range1 = elves[0].split('-')
  range2 = elves[1].split('-')
  range1[0].upto(range1[1]) do |station|
    elf1 << station
  end
  range2[0].upto(range2[1].strip) do |station|
    elf2 << station
  end
  unless (elf1 & elf2).empty?
    dumb_elf += 1
  end
  elf1.clear
  elf2.clear
end

puts dumb_elf