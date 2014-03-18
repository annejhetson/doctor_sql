require 'spec_helper'

describe Patient do
  it 'is initialized as an instance of Patient' do
    patient = Patient.new({:name => "Anne"})
    patient.should be_an_instance_of Patient
  end

  it 'saves' do
    patient = Patient.new({:name => "Liz", :birthday => "09/04/1984", :doctor_id => 1})
    patient.save
    Patient.all[0].name.should eq "Liz"
  end

  it 'initializes and saves an instance of patient' do
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => 1})
    Patient.all[0].birthday.should eq "1980-07-31 00:00:00"
  end

  it 'saves a doctor number' do
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => 1})
    Patient.all[0].doctor_id.should eq 1
  end

  it 'returns the doctor\'s name' do
    test_doctor = Doctor.create({:doctor_name => "Anne", :specialty => "Butts"})
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => "#{Doctor.all.last.id}"})
    Patient.all[0].doctor_name_method.should eq Doctor.all.last.doctor_name
  end

  it 'returns the patient\'s type of doctor' do
    test_doctor = Doctor.create({:doctor_name => "Anne", :specialty => "Butts"})
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => "#{Doctor.all.last.id}"})
    Patient.all[0].doctor_specialty.should eq Doctor.all.last.specialty
  end

  it 'deletes a patient' do
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => 1})
    patient2 = Patient.create({:name => "Liz", :birthday => "09/04/1984", :doctor_id => 1})
    Patient.all[0].delete
    Patient.all.length.should eq 1
  end

  it 'modifies a patient' do
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => 1})
    patient2 = Patient.create({:name => "Liz", :birthday => "09/04/1984", :doctor_id => 1})
    Patient.all[0].modifies("name", "Lets Go Anne!")
    Patient.all[1].name.should eq "Lets Go Anne!"
  end

  it 'finds patients in the database' do
    test_doctor = Doctor.create({:doctor_name => "Anne", :specialty => "Butts"})
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => "#{Doctor.all.last.id}"})
    Patient.find('patient.name', 'Anne')[0]['name'].should eq "Anne"
  end

  it 'finds the patient if a doctor name is entered' do
    test_doctor = Doctor.create({:doctor_name => "Anne", :specialty => "Butts"})
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => "#{Doctor.all.last.id}"})
    Patient.find("doctor.doctor_name", "Anne")[0]['specialty'].should eq "Butts"
  end

  it 'finds the patient if a doctor specialty is entered' do
    test_doctor = Doctor.create({:name => "Anne", :specialty => "Butts"})
    patient = Patient.create({:name => "Anne", :birthday => "07/31/1980", :doctor_id => "#{Doctor.all.last.id}"})
    Patient.find("doctor.specialty", "Butts")[0]['name'].should eq "Anne"
  end
end
