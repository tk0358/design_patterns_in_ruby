# これではクラスメソッドはできない（インスタンスメソッドができあがるだけ）

class SomeClass
  def a_method
    puts('hello from a method')
  end
end

SomeClass.a_method