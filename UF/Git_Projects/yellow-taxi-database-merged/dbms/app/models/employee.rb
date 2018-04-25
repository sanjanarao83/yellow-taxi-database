class Employee < ApplicationRecord
  establish_connection(:development)

  def self.checkID(empID)
    puts self.find_by_sql(["SELECT empid , first_name from Employee WHERE EMPID = ?", empID])
  end

  def self.create_user(first_name, last_name)
    self.find_by_sql("INSERT INTO Employee VALUES")
  end
end
