require 'csv'
@students = [] # an empty array accessable by all methods

################## Menu Methods ######################

def interactive_menu
  loop do
    # printing menu and asking user for input
    print_menu
    process(STDIN.gets.chomp)
    # do what user has selected
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def confirmation(selection)
  puts "\n You have selected option #{selection}\n "
end

def process(selection)
  confirmation(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

################## Input Methods ######################

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student has to the array
    cohort = :november
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
  # return array of students
  @students
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end 

################## Print Methods ######################

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(30)
  puts "-------------\n ".center(30)
end

def print_student_list
  @students.each_with_index do |name, index|
    puts "#{index + 1}. #{name[:name]} (#{name[:cohort]} cohort)"
  end
end

def print_footer
  # finally, we puts the total number of students
  puts "\n Overall, we have #{@students.count} great students\n "
end

################## Save/Load Methods ######################
def get_filename
  puts "\n Please enter a file name\n "
  filename = gets.chomp
end

def save_students
  # open CSV file for writing
  CSV.open(get_filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file << student_data
    end
  end
end

def load_students(filename = get_filename)
  # extract CSV data from file
  CSV.foreach(filename) do |row|
    name = row[0]
    cohort = row[1]
    add_student(name, cohort)
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command lane
  if filename.nil?
    filename = "students.csv"
  end
  if File.exists?(filename)
    load_students(filename)
    puts "\n Loaded #{@students.count} from #{filename}\n "
  else
    puts "\n Sorry, #{filename} doesn't exist.\n "
    exit
  end
end





try_load_students
interactive_menu