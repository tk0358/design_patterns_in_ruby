
class BankAccount
  attr_reader :balance

  def initialize(starting_balance=0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

class VirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(name, *args)
    s = subject
    s.send( name, *args ) 
  end

  def subject
    @subject = @creation_block.call unless @subject
    @subject
  end
end

account = VirtualProxy.new { BankAccount.new }
puts(account)