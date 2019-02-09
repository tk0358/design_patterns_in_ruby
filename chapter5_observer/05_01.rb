# Employeeの最初のバージョン
# 誰かになにかを伝えるのではなく、単に従業員の状態を保持する役割を果たすだけのEMployee

class Employee
  attr_reader :name
  attr_accessor :title, :salary

  def initialize( name, title, salary )
    @name = name
    @title = title
    @salary = salary
  end
end

# attr_accessorによりsalaryフィールドをアクセス可能にしているので、
# 従業員オブジェクトを昇給させることが出来る
fred = Employee.new("Fred Flintstone", "Crane Operator", 30000.0)

# フレッドを昇給させる
fred.salary = 35000.0
