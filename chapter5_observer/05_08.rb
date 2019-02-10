#push型のObserverパターン

module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

end

class Employee
  include Subject

  attr_reader :name, :title
  attr_accessor :salary

  def initialize( name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    old_salary = @salary
    @salary = new_salary
    @observers.each do |observer|
      observer.update_salary(self, old_salary, new_salary)
    end
  end

  def title=(new_title)
    old_title = @title
    @title = new_title
    @observers.each do |observer|
      observer.update_title(self, old_title, new_title)
    end
  end
end

class Payroll
  def update_salary( changed_employee, old_salary, new_salary )
    puts "#{changed_employee.name}のために小切手を切ります！"
    puts "彼の給料が、#{old_salary}から#{new_salary}に変わった！"
  end

  def update_title( changed_employee, old_title, new_title )
    puts "#{changed_employee.name}の役職が変更"
    puts "#{old_title}から#{new_title}へ"
    puts "#{new_title}の役職手当を調べる"
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30000.0)

payroll = Payroll.new
fred.add_observer(payroll)

fred.salary = 35000.0
fred.title = "Sales-person"
