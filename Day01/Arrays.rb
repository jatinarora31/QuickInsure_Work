
# ----------------- Arrays -------------------------------------

arr = [1,2,3,4,5,6]
puts arr[5]               # -> 6

# Create Array
arr2 = Array(["a","b","c","d"])
print arr2                # -> ["a", "b", "c", "d"]

# Get element
puts arr2.fetch(100,"e")    # -> e

# Take element
print arr.take(2)           # [1,2]

# Find length
puts arr2.length           # -> 4

# Array First element
puts arr2.first            # -> a

# Array last element
puts arr2.last            # -> b

# drop element
puts arr2.drop(2)         # -> c,d

# check for empty
puts arr2.empty?          # -> false

# Include                 # -> true
puts arr2.include?("b")

# Add element
arr2.push("e")
puts arr2                 # -> a,b,c,d,e

# Add at beginning
arr2.unshift(nil)
print arr2                # -> nil,a,b,c,d,e

#Remove element
arr2.pop
puts arr2                 # -> nil,a,b,c,d

arr2.compact!
print arr2                # -> a,b,c,d,