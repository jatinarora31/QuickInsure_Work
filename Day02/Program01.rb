puts "Enter you battery percentage"
num = gets.chomp.to_i

case num
  when 0
    puts "Phone is going to be switched off"
  when 1..20
    puts "Battery is in between 1-20 %"
  when 21..40
    puts "Battery is in between 21-40 %"
  when 41..60
    puts "Battery is in between 41-60 %"
  when 61..80
    puts "Battery is in between 61-80 %"
  when 81...100 
    puts "Battery is in between 81-90 %"
  else 
    puts "Battery is full (100%)"
end