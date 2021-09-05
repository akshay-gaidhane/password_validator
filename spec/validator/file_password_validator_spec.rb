require 'rails_helper'
require 'csv'

RSpec.describe FilePasswordValidator, type: :model do

  describe "validations" do
    it "Password must contain 1 number" do
      rows = []
      CSV.foreach("#{Rails.root}/spec/validator/inputs/input1.csv", headers: true, skip_blanks: true) do |row|
        next if row.to_hash.values.all?(&:nil?)
        rows << row
      end
      
      validator_service = FilePasswordValidator.new(rows.first).validate_password
      expect(validator_service["status"]).to be_a(Integer)
    end

    it "Password must contain 1 lowercase letter" do
      rows = []
      CSV.foreach("#{Rails.root}/spec/validator/inputs/input2.csv", headers: true, skip_blanks: true) do |row|
        next if row.to_hash.values.all?(&:nil?)
        rows << row
      end
      validator_service = FilePasswordValidator.new(rows.first).validate_password
      expect(validator_service["status"]).to be_a(Integer)
    end

    it "Password must contain 1 uppercase letter" do
      rows = []
      CSV.foreach("#{Rails.root}/spec/validator/inputs/input3.csv", headers: true, skip_blanks: true) do |row|
        next if row.to_hash.values.all?(&:nil?)
        rows << row
      end
      validator_service = FilePasswordValidator.new(rows.first).validate_password
      expect(validator_service["status"]).to be_a(Integer)
    end

    it "Password must has atleast 10 charecters and atmost 16 characters" do
      rows = []
      CSV.foreach("#{Rails.root}/spec/validator/inputs/input4.csv", headers: true, skip_blanks: true) do |row|
        next if row.to_hash.values.all?(&:nil?)
        rows << row
      end
      validator_service = FilePasswordValidator.new(rows.first).validate_password
      expect(validator_service["status"]).to be_a(Integer)
    end
    
    it "Password should not contain 3 repeating charecters" do
      rows = []
      CSV.foreach("#{Rails.root}/spec/validator/inputs/input5.csv", headers: true, skip_blanks: true) do |row|
        next if row.to_hash.values.all?(&:nil?)
        rows << row
      end
      validator_service = FilePasswordValidator.new(rows.first).validate_password
      expect(validator_service["status"]).to be_a(Integer)
    end
  end
  
end