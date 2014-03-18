require './lib/Doctor'
require './lib/Patient'

DB = PG.connect({:dbname => 'hospital'})

def main_menu
system('clear')
  puts "WELCOME TO ANOTHER DAY OF BORING WORK"
  puts "====================================="
  puts "+  D - Doctor                       +"
  puts "+  P - Patient                      +"
  puts "+  X - Exit                         +"
  puts "====================================="

  user_input = gets.downcase.chomp

  case user_input
  when 'd'
    doctor_menu
  when 'p'
    patient_menu
  when 'x'
    puts "Now, let's go party! ┏(-_-)┛┗(-_-﻿ )┓┗(-_-)┛┏(-_-)┓"
  else
    puts "POOPIE PANTS! NOT A VALID INPUT"
  end
end

def patient_menu
  system('clear')
  puts "WELCOME TO ANOTHER DAY OF BORING WORK"
  puts "====================================="
  puts "+  A - Add a patient                +"
  puts "+  F - Find a patient               +"
  puts "+  D - Delete a patient             +"
  puts "+  M - Modify a patient             +"
  puts "+  L - List menu                    +"
  puts "+  O - Go to doctor menu            +"
  puts "+  X - Exit                         +"
  puts "====================================="

  user_input = gets.downcase.chomp

  case user_input
  when 'x'
    puts "Now, let's go party! ┏(-_-)┛┗(-_-﻿ )┓┗(-_-)┛┏(-_-)┓"
  when 'a'
    add_patient
  when 'f'
    find_patient
  when 'd'
    delete_patient
  when 'm'
    modify_patient
  when 'l'
    list_patient_menu
  when 'o'
    doctor_menu
  else
    puts "NOT A VALID INPUT!!! >__<"
    patient_menu
  end
end

def add_patient
  list_all_doctors
  puts "Enter new patient's name"
  patient_name = gets.downcase.chomp
  puts "Enter #{patient_name}'s birthday"
  bday = gets.chomp
  puts "Enter #{patient_name}'s doctor's number"
  patient_doctor = gets.chomp.to_i

  user_doctor_id = Doctor.all[patient_doctor-1].id

  Patient.create({:name => patient_name, :birthday => bday, :doctor_id => user_doctor_id})
  puts "Patient #{Patient.all.last.name} has been added to our 'poopie' hospital database."
  puts "Enter 'A' to add another patient."
  puts "Enter 'B' to go back to the patient menu."

  user_input = gets.downcase.chomp

  case user_input
  when 'a'
    add_patient
  when 'b'
    patient_menu
  else
    puts "Not a valid input!"
    patient_menu
  end
end

def delete_patient
  list_all_patients
  puts "Pick a patient to destroy!! hahahahaha"
  number = gets.chomp.to_i
  puts "Destroying patient #{Patient.all[number-1].name}..."
  puts "Please stand by..."
  sleep(1)
  Patient.all[number-1].delete
  puts ".....DESTROYED!!!!..┗(-_-)┛"
  sleep(1)
  patient_menu
end

def list_patient_menu
  puts "All patients:"
  list_all_patients
  puts "Press Return to return to main menu"
  gets
  patient_menu
end

def modify_patient
  list_all_patients
  puts "Pick a patient number you like to modify"
  patient_number = (gets.chomp.to_i) - 1
  puts "Enter '1' to modify patient's name"
  puts "Enter '2' to modify patient's birthday"
  puts "Enter '3' to modify patient's doctor"
  choice = gets.chomp.to_i
    case choice
    when 1
      what_modify = 'name'
    when 2
      what_modify = 'birthday'
    when 3
      list_all_doctors
      what_modify = 'doctor_id'
    else
      puts "May I suggest a mental hospital? Poopie head!!!"
    end
  puts "what do you want to modify to"
  modify_to = gets.downcase.chomp
    if choice == 3
    modify_to = Doctor.all[(modify_to).to_i - 1].id
    end
  puts "Processing...#{Patient.all[patient_number].name}..."
  sleep(1)
  Patient.all[patient_number].modifies(what_modify, modify_to)
  puts "....MOD....I...FIED.....eh eh eh eh eh."
  sleep(1)
  patient_menu
end

def find_patient
  user_input_key = {'1' => 'patient.birthday', '2' => 'patient.name', '3' => 'doctor.doctor_name', '4' => 'doctor.specialty'}
  puts "Enter '1' to search by birthday"
  puts "Enter '2' to search by name"
  puts "Enter '3' to search by doctor name"
  puts "Enter '4' to search by doctor specialty"
  input = gets.chomp
  puts "What are you looking for?"
  what_to_find = gets.downcase.chomp

  results = Patient.find(user_input_key[input], what_to_find)

  results.each_with_index do |result, index|
    puts "#{index + 1}: #{result['name'].capitalize} - #{result['birthday']} - #{result['doctor_name'].capitalize} - #{result['specialty'].capitalize}"
  end
  puts "Press enter to go back to main menu"
  gets
  main_menu
end


def doctor_menu
  system('clear')
  puts "WELCOME TO ANOTHER DAY OF BORING WORK"
  puts "====================================="
  puts "+  A - Add a doctor                 +"
  puts "+  F - Find a doctor                +"
  puts "+  D - Delete a doctor              +"
  puts "+  M - Modify a doctor              +"
  puts "+  L - List menu                    +"
  puts "+  P - To Patient menu"
  puts "+  X - Exit                         +"
  puts "====================================="

  user_input = gets.downcase.chomp

  case user_input
  when 'x'
    puts "Now, let's go party! ┏(-_-)┛┗(-_-﻿ )┓┗(-_-)┛┏(-_-)┓"
  when 'a'
    add_doctor
  when 'f'
    find_doctor
  when 'd'
    delete_doctor
  when 'm'
    modify_doctor
  when 'l'
    list_menu
  when 'p'
    patient_menu
  else
    puts "NOT A VALID INPUT!!! >__<"
    doctor_menu
  end
end

def add_doctor
  puts "Enter doctor's name"
  doctor_name = gets.downcase.chomp
  puts "Enter #{doctor_name.capitalize}'s specialty"
  specialty = gets.downcase.chomp
  Doctor.create({:name => doctor_name, :specialty => specialty})
  puts "Doctor #{Doctor.all.last.name} has been added to our 'poopie' hospital database."
  puts "Enter 'A' to add another doctor."
  puts "Enter 'B' to go back to the doctor menu."

  user_input = gets.downcase.chomp

  case user_input
  when 'a'
    add_doctor
  when 'b'
    doctor_menu
  else
    puts "Not a valid input!"
  end
end

def list_menu
  puts "All doctors:"
  list_all_doctors
  puts "Press Return to return to main menu"
  gets
  doctor_menu
end

def delete_doctor
  list_all_doctors
  puts "Pick a doctor to destroy!! hahahahaha"
  number = gets.chomp.to_i
  puts "Destroying doctor #{Doctor.all[number-1].name.capitalize}..."
  puts "Please stand by..."
  sleep(1)
  Doctor.all[number-1].delete
  puts ".....DESTROYED!!!!..┗(-_-)┛"
  sleep(1)
  doctor_menu
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
  modified = gets.downcase.chomp
  puts "Modifying doctor #{Doctor.all[index-1].name.capitalize}..."
  sleep(1)
  Doctor.all[index-1].modify_doctor(category, modified)
  puts "....MOD....I...FIED.....eh eh eh eh eh."
  sleep(1)
  doctor_menu
end


def list_all_doctors
  Doctor.all.each_with_index do |doctor, index|
    puts "#{index+1}: #{doctor.name.capitalize} ☞ #{doctor.specialty.capitalize}"
  end
end

def list_all_patients
  Patient.all.each_with_index do |patient, index|
    puts "#{index+1}: #{patient.name.capitalize} ☞  #{patient.doctor_name.capitalize} ☞ #{patient.doctor_specialty.capitalize}"
  end
end
main_menu
