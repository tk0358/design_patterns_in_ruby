# Enumerableをミックスインすると簡単に、さまざまなメソッドを組み込める例

class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=>(other)
    balance <=> other.balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end

ruru_account = Account.new("ruru", 500)
akari_account = Account.new("akari", 2100)
emiri_account = Account.new("emiri", 2100)
mika_account = Account.new("mika", 1500)
momoka_account = Account.new("momoka", 900)

my_port = Portfolio.new
my_port.add_account(ruru_account)
my_port.add_account(akari_account)
my_port.add_account(emiri_account)
my_port.add_account(mika_account)
my_port.add_account(momoka_account)

p my_port.any?{|account| account.balance > 2000}
p my_port.all?{|account| account.balance >= 10}
