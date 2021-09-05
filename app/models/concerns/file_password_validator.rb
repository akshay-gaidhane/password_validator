class FilePasswordValidator
  MULTIPLE_NUMBERS = /\d.*?/
  UPPERCASE_LOWERCASE = /([a-z].*[A-Z])|([A-Z].*[a-z])/
  
  def initialize(row)
    @row = row
    # @rows = [["User 1", "Aqpfk1swods"], ["User 2", "QPFJWz1343439"], ["User 3", "PFSHH78KSM"], ["User 4", "Abc123"], ["User 5", "abcdefghijklmnop"], ["User 6", "AAAfk1swods"]]
  end

  # Check if the password has the specified score.
  def validate_password
    score = []
    score << repetitive_substring(@row["password"])
    score << string_length(@row["password"])
    score << upper_lower_case(@row["password"])
    score << digit(@row["password"])
    character_change = score.sum
    @row["status"] = (character_change.zero? ? "Strong" : character_change)
    return @row
  end

  # Repetitive 3 same charecters 
  def repetitive_substring(password)
    check = password.scan(/((.)\2{2,})/)
    check.empty? ? 0 : check.count
  end

  # charecters should be in 10-16 range 
  def string_length(password)
    if password.size >= 10 && password.size < 17
      return 0
    else
      return password.size > 16 ? (16 - password.size) : 10 - password.size
    end
  end

  def upper_lower_case(password)
    (password =~ UPPERCASE_LOWERCASE).nil? ? 1 : 0
  end

  def digit(password)
    (password =~ MULTIPLE_NUMBERS).nil? ? 1 : 0
  end

end
