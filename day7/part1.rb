#!/usr/bin/env ruby

require 'json'
def set_size(parent, hash)
  hash.each do |k,v|
    if k == "size"
      next
    end
    if v.is_a?(Hash)
      set_size(k, v)
      hash["size"] += hash[k]["size"] unless parent.nil?
    else
      hash["size"] += v
    end
  end
  return hash
end

def get_smolboi_total(hash, total)
  hash.each do |k,v|
    if v.is_a?(Hash)
      total = get_smolboi_total(v, total)
    end
    if k == "size"
      if v <= 100000
        total += v
      end
    end
  end
  return total
end

input = Array.new
File.readlines('input').each do |line|
  input << line
end


cwd = String.new
fs = {"/" => {}}
fs["/"]["size"] = 0
#Lets figure out what they got on the thing. 
line_num = 0
input.each do |line|
  line_num += 1
  if line =~ /^\$/
    command = line.split
    if command[1] == "ls"
      #Yep that is, in fact, an ls command. 
      next
    elsif command[1] == "cd"
      # Change CWD
      if command[2] == ".."
        # /foo/bar -> /foo || /foo -> /
        cwd = "/" if cwd.split('/').count == 2
        cwd = cwd.split('/')[0..-2].join('/') unless cwd.split('/').count == 2
        next
      elsif command[2] == "/"
        cwd = "/"
        next
      else
        if cwd == "/"
          # / -> /foo
          cwd += "#{command[2]}"
          next
        else
          # /foo -> /foo/bar
          cwd += "/#{command[2]}"
          next
        end
      end
    else
      #What are you doing step bro
    end
  else
    #We type ls and it gave us stuff back, much wow. 
    inode = line.split
    path = cwd + ("#{inode[1]}") if cwd == "/"
    path = cwd + ("/#{inode[1]}") unless cwd == "/"
    path = path.split('/')
    path[0] = "/" #Split makes the first element empty
    if fs.dig(*path).nil?
      if inode[0] == "dir"
        #We found a directory, go us. 
        new_path = fs.dig(*path[0..-2]) #This actually makes a pointer to the original fs object
        new_path[path[-1]] = Hash.new
        new_path[path[-1]]["size"] = 0
        next
      else
        # Files. Probably elf smut. 
        new_path = fs.dig(*path[0..-2]) #This actually makes a pointer to the original fs object
        new_path[path[-1]] = inode[0].to_i
        next
      end
    end
  end
end


total_smolboi_size = 0
set_size(nil, fs)
total_smolboi_size = get_smolboi_total(fs, total_smolboi_size)

puts total_smolboi_size