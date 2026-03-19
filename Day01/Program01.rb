p = {}

while true
  
  puts "0. EXIT"
  puts "1. Add Employee"
  puts "2. Display All Employees"
  puts "3. Update Employees"
  puts "4. Delete Employee"
  num = gets.chomp.to_i
  case num
  
  when 0 then break

  when 1
    id = p.empty? ? 1 : p.keys.max+1

    puts "-------------------------------------"
      puts "Enter Employee Name"
      name = gets.chomp
      puts "Enter Employee Salary"
      salary = gets.chomp.to_i
      p[id] = {name: name,salary: salary}
      
    puts "--------- Employee Added Successfully ----------"

  when 2
    puts "--------- Displaying Employees ----------"
    if p.empty?
      puts "No Records Found"
    else
      puts p
    end
    puts "-----------------------------------------"
  
  when 3

    puts "Enter Employee Id"
    update_id = gets.chomp.to_i
    if p.include?(update_id)
      puts "Enter Employee Name"
      name = gets.chomp
      puts "Enter Employee Salary"
      salary = gets.chomp.to_i
      
      p[update_id][:name] = name
      p[update_id][:salary] = salary

    else
      puts "-------------------------------------------------"
      puts "No record found with id #{update_id}"
      puts "-------------------------------------------------"
    end

  when 4
    puts "Enter Employee Id"
    delete_id = gets.chomp.to_i
    if p.include?(delete_id)
      p.delete(delete_id)
      puts "--------- Employee Deleted Successfully ----------"
    else
      puts "-------------------------------------------------"
      puts "--------- Record not found with id #{delete_id} ----------"
      puts "-------------------------------------------------"
    end
  else 
    puts "Invalid Input"
  end
end