class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts("藻 #{@name} は日光を浴びて育ちます。")
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts("スイレン #{@name} は浮きながら日光を浴びて育ちます。")
  end
end