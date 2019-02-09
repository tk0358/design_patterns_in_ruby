# Employee第２バージョン
# 給料の変更を経理部門(Payroll)に逐次通知し続けるパターン

class Payroll
  def update( changed_employee )
    puts "#{changed_employee.name}のために小切手を切ります！"
    puts "彼の給料はいま#{changed_employee.salary}です！"
  end
end

class Employee
  attr_reader :name, :title
  attr_accessor :salary

  def initialize( name, title, salary, payroll)
    @name = name
    @title = title
    @salary = salary
    @payroll = payroll
  end

  def salary=(new_salary)
    @salary = new_salary
    @payroll.update(self)
  end
end

# Fredの資金を賃金を変更できる
payroll = Payroll.new
fred = Employee.new('Fred', 'Crane Operator', 30000, payroll)
fred.salary = 35000
