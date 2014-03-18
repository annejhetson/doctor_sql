require './lib/Doctor'

DB = PG.connect({:dbname => 'hospital'})

def main_menu
  system('clear')
  puts "WELCOME TO ANOTHER DAY OF BORING WORK"
  puts "====================================="
  puts "+  A - Add a doctor                 +"
  puts "+  D - Delete a doctor              +"
  puts "+  M - Modify a doctor              +"
  puts "+  L - List menu                    +"
  puts "+  X - Exit                         +"
  puts "====================================="

  user_input = gets.downcase.chomp

  case user_input
  when 'x'
    puts "Now, let's go party! ┏(-_-)┛┗(-_-﻿ )┓┗(-_-)┛┏(-_-)┓"
  when 'a'
    add_doctor
  when 'd'
    delete_doctor
  when 'm'
    modify_doctor
  when 'l'
    list_menu
  else
    puts "NOT A VALID INPUT!!! >__<"
  end
end

def add_doctor
  puts "Enter doctor's name"
  doctor_name = gets.chomp
  puts "Enter #{doctor_name}'s specialty"
  specialty = gets.chomp
  Doctor.create({:name => doctor_name, :specialty => specialty})
  puts "Doctor #{Doctor.all.last.name} has been added to our 'poopie' hospital database."
  puts "Enter 'A' to add another doctor."
  puts "Enter 'B' to go back to the main menu."

  user_input = gets.downcase.chomp

  case user_input
  when 'a'
    add_doctor
  when 'b'
    main_menu
  else
    puts "Not a valid input!"
  end
end

def list_menu
  puts "All doctors:"
  list_all_doctors
  puts "Press Return to return to main menu"
  gets
  main_menu
end

def delete_doctor
  list_all_doctors
  puts "Pick a doctor to destroy!! hahahahaha"
  number = gets.chomp.to_i
  puts "Destroying doctor #{Doctor.all[number-1].name}..."
  puts "Please stand by..."
  sleep(1)
  Doctor.all[number-1].delete
  puts ".....DESTROYED!!!!..┗(-_-)┛"
  sleep(1)
  main_menu
end

def modify_doctor
  list_all_doctors
  puts "Pick the doctor you want to modify."
  index = gets.chomp.to_i
  puts "Enter '1' to change the name and '2' to change specialty."
  category = gets.chomp.to_i
    if category == 1
      category = "name"
    elsif category == 2
      category = "specialty"
    else
      puts "WRONG INPUT..Blah blah blah."
    end
  puts "What do you want to modify it to."
  modified = gets.chomp
  puts "Modifying doctor #{Doctor.all[index-1].name}..."
  sleep(1)
  Doctor.all[index-1].modify_doctor(category, modified)
  puts "....MOD....I...FIED.....eh eh eh eh eh."
  sleep(1)
  main_menu
end


def list_all_doctors
  Doctor.all.each_with_index do |doctor, index|
    puts "#{index+1}: #{doctor.name} ☞ #{doctor.specialty}"
  end
end
main_menu
