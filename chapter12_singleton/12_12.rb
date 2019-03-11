require 'singleton'

class Manager
  include Singleton

  def manage_resources
    puts("I am managing my resources")
  end
end

class Manager
  public_class_method :new
end

m = Manager.new
