class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("アヒル #{@name} は食事中です。")
  end

  def speak
    puts("アヒル #{@name} はガーガー鳴いています。")
  end

  def sleep
    puts("アヒル #{@name} は静かに眠っています。")
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("カエル #{@name} は食事中です。")
  end

  def speak
    puts("カエル #{@name} はゲロゲロッと鳴いています。")
  end

  def sleep
    puts("カエル #{@name} は眠りません。一晩中ゲロゲロ鳴いています。")
  end
end

class Tiger
  def initialize(name)
    @name = name
  end

  def eat
    puts("トラ #{@name} は食べたいものを何でも食べます。")
  end

  def speak
    puts("トラ #{@name} はガオーとほえています。")
  end

  def sleep
    puts("トラ #{@name} は眠くなったら眠ります。")
  end
end