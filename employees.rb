class Employee
  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss =
      name, title, salary, boss
    @employees = []
    boss.add_employee(self) unless boss.nil?
  end

  def boss=(boss)
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  protected
  attr_reader :employees, :name, :title, :salary, :boss
end

class Manager < Employee
  def initialize(name, title, salary, boss=nil)
    super(name,title,salary,boss)
  end

  def add_employee(employee)
    @employees << employee
  end

  def bonus(multiplier)
    total_salary * multiplier
  end

  def total_salary
    total = 0
    @employees.each do |employee|
      if employee.is_a?(Manager)
        total += employee.salary
        total += employee.total_salary
      else
        total += employee.salary
      end
    end
    total
  end

end

ned = Manager.new('Ned',"Founder", 1000000)
darren = Manager.new('Darren', 'TA Manager',78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)
