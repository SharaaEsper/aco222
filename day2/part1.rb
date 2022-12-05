#!/usr/bin/env ruby

input = Array.new
File.readlines('input').each do |line|
  input << line
end

#A/X = Rock(1pt) B/Y = Paper(2pt) C/Z = Scissors(3pt)
#Win = 6pt, Draw = 3pt, Loss = 0pt

score = 0
input.each do |round|
  if round.split[0] == "A"
    if round.split[1] == "X"
      #Rock v Rock
      score += 4
    elsif round.split[1] == "Y"
      #Rock v Paper 
      score += 8
    else
      #Rock v Scissors
      score += 3
    end
  elsif round.split[0] == "B"
    if round.split[1] == "X"
      #Paper v Rock
      score += 1
    elsif round.split[1] == "Y"
      #Paper v Paper 
      score += 5
    else
      #Paper v Scissors
      score += 9
    end
  elsif round.split[0] == "C"
    if round.split[1] == "X"
      #Scissors v Rock
      score += 7
    elsif round.split[1] == "Y"
      #Scissors v Paper 
      score += 2
    else
      #Scissors v Scissors
      score += 6
    end
  end
end

puts score