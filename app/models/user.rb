require 'csv'
class User < ApplicationRecord
  has_secure_password

  # Import to convert rows in csv format
  def self.import(file)
    if file.path.split('.').last.to_s.downcase != 'csv'
      return "Please Select csv file"
    end
    row_validator = []
    CSV.foreach(file.path, headers: true, skip_blanks: true) do |row|
      next if row.to_hash.values.all?(&:nil?)
      row_validator << FilePasswordValidator.new(row).validate_password
    end
    row_validator
  end
  
  # Save and display record
  def self.save_and_result(result)
    report = []
    strong_password_values = []
    # Processing for displaying results
    result.each do |l|
      if l["status"] == "Strong"
        report << "#{l["name"]} was successfully saved"
        strong_password_values << { username: l['name'], password_digest: l['password'], created_at: Time.now, updated_at: Time.now } # creating hash for bulk insert
      else
        report << "Change #{l["status"]} character of #{l["name"]}'s password"
      end
    end
    bulk_create_users(strong_password_values)
    report
  end

  private
    def self.bulk_create_users(strong_password_values)
      User.insert_all(strong_password_values)
    end
end
