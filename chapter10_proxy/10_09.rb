#AccountProtectionProxyをmethod_missingテクニックを使って書き直す

require 'etc'

class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end

  def method_missing(name, *args)
    check_access
    @subject.send( name, *args )
  end

  def check_access
    if Etc.getlogin != @owner_name
      raise "Illeagal access: #{Etc.getlogin} cannot access account."
    end
  end
end

s = AccountProtectionProxy.new("a simple string", 'tk0358')
puts "The length of the string is #{s.length}"
s = AccountProtectionProxy.new("a simple string", 'red')
puts "The length of the string is #{s.length}"   # => raise "Illegal access:..."