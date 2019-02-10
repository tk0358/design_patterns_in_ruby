# コードブロックをオブザーバとしてサブジェクトに渡す

module Subject
  def initialize
    @observers = []
  end

  def add_observer(&observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.call(self)
    end
  end
end

class Employee
  include Subject

  attr_accessor :name, :title, :salary

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



fred = Employee.new('Fred', 'Crane Operator', 30000.0)

fred.add_observer do |changed_employee|
  puts "#{changed_employee.name}のために小切手を切ります！"
  puts "彼の給料はいま#{changed_employee.salary}です！"
end

fred.salary = 35000.0

fred.add_observer do |changed_employee|
  puts "#{changed_employee.name}に新しい税金の請求書を送ります。"
end

fred.salary = 90000.0
