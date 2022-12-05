#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end

def get_prio(char)
  prio = char.ord - 96
  if prio < 0
    prio += 58
  end
  return prio
end

total_prio = 0
dumb_counter = 0
sacks = Array.new
input.each do |sack|
  dumb_counter += 1
  sacks << sack.split('')
  if dumb_counter == 3
    total_prio += get_prio((sacks[0] & sacks[1] & sacks[2])[0])
    sacks.clear
    dumb_counter = 0
  end
end

puts total_prio