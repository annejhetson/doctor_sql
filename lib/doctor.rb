require 'pg'

class Doctor

attr_reader :doctor_name, :specialty, :id

  def initialize(input_hash)
    @doctor_name = input_hash[:doctor_name]
    @specialty = input_hash[:specialty]
    @id = input_hash[:id]
  end

  def Doctor.all
    results = DB.exec("SELECT * FROM doctor;")
    doctors = []
    results.each do |result|
      doctor_name = result['doctor_name']
      specialty = result['specialty']
      id = result['id'].to_i
      doctors << Doctor.new({:doctor_name => doctor_name, :specialty => specialty, :id => id})
    end
    doctors
  end

  def Doctor.create(input_hash)
    doctor = Doctor.new(input_hash)
    doctor.save
  end

  def delete
    DB.exec("DELETE FROM doctor WHERE id = #{id};")
  end

  def modify_doctor(what_to_modify, modify_to)
    DB.exec("UPDATE doctor SET #{what_to_modify} = '#{modify_to}' WHERE id = #{id};")
  end

  def save
    DB.exec("INSERT INTO doctor (doctor_name, specialty) VALUES ('#{@doctor_name}', '#{@specialty}');")
  end

end
