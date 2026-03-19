puts "Hello world 1"

def logger
  puts "Hello World 2"
  yield
  puts "Hello World 3"
  yield
  puts "Hello world 3 again"
end

puts "Hello World 4"

logger {puts "hello from block (yield)"}

puts "Hello World 5"

logger do
  p [1,2,3]
end

puts "------------------Finish------------------"

# Procs
def take_proc(proc)
  [1,2,3,4,5].each do |n|
    proc.call n
  end
end
proc = Proc.new do |n|
  puts "#{n}, proc called"
end

take_proc(proc)

puts "-----------------------------------------"

# Lambda
l1 = -> {puts "First lambda func"}
l1.call

l2 = -> {return 10}
puts l2.call

my_procs = Proc.new {return 15}
puts my_procs.call