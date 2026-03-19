class Duck
  private
  def speak
    puts "Quack"
  end
end

class Person
  def speak
    puts "Hello"
  end
end

class Animal
end

def make_speak(object)
  object.speak
end

object = Duck.new
puts object.respond_to?(:speak)
puts object.send(:speak)