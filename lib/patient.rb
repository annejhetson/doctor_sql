require 'pg'

class Patient

  attr_reader :name, :id, :birthday, :doctor_id

  def initialize(input_hash)
    @name = input_hash[:name]
    @birthday = input_hash[:birthday]
    @id = input_hash[:id]
    @doctor_id = input_hash[:doctor_id]
  end

  def Patient.all
    results = DB.exec("SELECT * FROM patient;")
    patients = []
    results.each do |result|
      name = result['name']
      birthday = result['birthday']
      id = result['id'].to_i
      doctor_id = result['doctor_id'].to_i
      patients << Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => id})
    end
    patients
  end

  def Patient.create(input_hash)
    patient = Patient.new(input_hash)
    patient.save
  end

  def Patient.find(type, user_input)
    results = DB.exec("SELECT * FROM patient INNER JOIN doctor on
      patient.doctor_id = doctor.id WHERE #{type} LIKE '#{user_input}%';")
    found = []
    results.each do |result|
        found << result
      end
    found
  end

  def delete
    DB.exec("DELETE FROM patient WHERE id = #{id};")
  end

  def modifies(what_modify, modify_to)
    DB.exec("UPDATE patient SET #{what_modify} = '#{modify_to}' WHERE id = #{id}")
  end

  def save
    DB.exec("INSERT INTO patient (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id});")
  end

  def doctor_name_method
    results = DB.exec("SELECT doctor_name FROM doctor WHERE id = #{@doctor_id};")
    results[0]['doctor_name']
  end

  def doctor_specialty
    results = DB.exec("SELECT specialty FROM doctor WHERE id = #{@doctor_id};")
    results[0]['specialty']
  end
end
