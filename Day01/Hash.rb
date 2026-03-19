# --------------------- HASH -----------------------------------

# Person Object
person1 = {
  name:"Jatin",
  age:23,
  city:"Pune"
}
puts person1[:name]    # -> Jatin

person2 = {
  "name"=>"Jatin",
  "age"=>23,
  "city"=>"Pune"
}
puts person2["age"]    # -> 23
puts person2["city"]   # -> Pune
