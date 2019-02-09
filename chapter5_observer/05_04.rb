#Observerパターンを継承で実装

class Subject
  def initialize
    @observers=[]
  end

  def add_observer(observer)
    @observers << observer
  end
  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class Employee < Subject
  attr_reader :name, :title
  attr_accessor :salary

  def initialize( name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

class Payroll
  def update( changed_employee )
    puts "#{changed_employee.name}のために小切手を切ります！"
    puts "彼の給料はいま#{changed_employee.salary}です！"
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30000.0)

payroll = Payroll.new
fred.add_observer(payroll)

fred.salary = 35000.0
