require 'spec_helper'

describe Doctor do
  it 'creates an instance of Doctor' do
    test_doctor = Doctor.new({:name => "Anne"})
    test_doctor.should be_an_instance_of Doctor
  end

  it 'saves all of the doctors' do
    test_doctor = Doctor.new({:name => "Anne", :specialty =>
      "Butts"})
    test_doctor.save
    Doctor.all[0].specialty.should eq "Butts"
  end

  it 'creates an instance of Doctor and saves it' do
    test_doctor = Doctor.create({:name => "Liz", :specialty => "Toe Nails"})
    Doctor.all[0].specialty.should eq "Toe Nails"
    Doctor.all[0].id.should be_an_instance_of Fixnum
  end

  it 'deletes a doctor' do
    test_doctor = Doctor.create({:name => "Anne", :specialty =>
      "Butts"})
    test_doctor2 = Doctor.create({:name => "Liz", :specialty => "Toe Nails"})
    Doctor.all[1].delete
    Doctor.all.length.should eq 1
  end

  it 'modifies a doctor' do
    test_doctor = Doctor.create({:name => "Anne", :specialty =>
      "Butts"})
    test_doctor2 = Doctor.create({:name => "Liz", :specialty => "Toe Nails"})
    Doctor.all[1].modify_doctor("specialty", "Brains")
    Doctor.all[1].specialty.should eq "Brains"
  end
end
