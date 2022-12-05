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
input.each do |sack|
  h1 = sack[0, (sack.length / 2)].split('')
  h2 = sack[(sack.length / 2), sack.length].split('')
  total_prio += get_prio((h1 & h2)[0])
end

puts total_prio