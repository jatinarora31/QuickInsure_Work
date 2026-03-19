a = [1,2,3,4,5,6,7]

# Each
a.each {|i| puts i*2}

a.each do |i|
  puts "each do -> #{i*2}"
end

# Each
p = ["jatin","rohan","kapil"]
p.each do |s|
  puts s+"san"
end

# For
for i in 1..5
  puts "#{i} zombies incoming"
end

# While
i=0
while i<5 do
  puts "#{i} zombies incoming"
  i+=1
end

# Times
5.times do |i|
  puts "times -> #{i}"
end

# Upto
5.upto(10) {|i| puts "upto -> #{i}"}

# downto
15.downto(11) {|i| puts "downto -> #{i}"}