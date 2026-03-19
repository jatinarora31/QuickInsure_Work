
# -------------------- String ----------------------------
# String Concat
n = "Quick"
n.concat("Insure")
puts n                 # -> QuickInsure

# String Reverse
puts n.reverse()       # -> erusnIkciuQ

# Get object id
puts "Object_id of n is #{n.object_id}"   # -> Object_id of n is 16

# Get Length of String
puts "Length of n i #{n.length()}"    # -> Length of n i 11

# Include?
puts n.include?("sure")         # -> true

# Index Of
puts n.index("k")               # -> 4

# Return hash code
puts "Hash code of n is #{n.hash()}"    # -> Hash code of n is 158428048

# eql?
puts n.eql?("QuickInsure")    # -> true

# Capitalize
puts n.capitalize         # -> Quickinsure

# Downcase
puts n.downcase           # -> quickinsure

# Upcase
puts n.upcase            # -> QUICKINSURE

# Array of character
print "#{n.chars()}\n"    # -> ["Q", "u", "i", "c", "k", "I", "n", "s", "u", "r", "e"]

# Split
print "#{n.split('')}\n"   # -> ["Q", "u", "i", "c", "k", "I", "n", "s", "u", "r", "e"]

# Multiply
puts n*3                  # -> QuickInsureQuickInsureQuickInsure

# Get Char by index
puts n[1]                 # -> u

# Get SubString
puts n[1,4]               # -> uick

# Count
puts n.count('u')         # -> 2
