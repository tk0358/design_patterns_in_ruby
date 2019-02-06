class BankAccount
  attr_accessor :balance
  
  def initialize( account_owner )
    @owner = account_owner
    @balance = 0
  end

  def deposit( amount )
    @balance = @balance + amount
  end

  def wighdraw( amount )
    @balance = @balance - amount
  end
end
