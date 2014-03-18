require 'rspec'
require 'pg'
require 'hospital'
require 'doctor'
require 'patient'

DB = PG.connect({:dbname => 'hospital_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
  end
end


