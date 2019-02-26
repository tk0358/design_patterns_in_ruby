# 10-5-4 プロキシーを簡単に
# 改良版のAccountProxy

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

class AccountProxy
  def initialize(real_account)
    @subject = real_account
  end

  def method_missing(name, *args)
    puts "Delegating #{name} message to subject."
    @subject.send(name, *args)
  end
end

ap = AccountProxy.new( BankAccount.new(100) )
ap.deposit(25)
ap.withdraw(50)
puts "account balance is now: #{ap.balance}"
