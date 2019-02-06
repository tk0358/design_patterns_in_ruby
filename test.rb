module Chatty
  def say_hi
     puts "Hello, my name is #{name}"
     puts "My job title is #{title}"
     puts "I work in the #{department}"
  end
end

class Employee
  include Chatty
  def name
    'Ruru'
  end
  def title
    'Dog'
  end
  def department
    'Walking'
  end
end
