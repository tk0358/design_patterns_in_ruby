class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    # 文字列を表示する
  end
end

# RendererはTextObjectクラスのオブジェクトの表示に使う
class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text = text
    @size_inches =  size_inches
    @color = color
  end
end

# Rendererで表示したいが、インターフェースが微妙に異なる
class BritishTextObject
  attr_reader :string, size_mm, :colour
  
  # ...

end

bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto
  def color
    colour
  end

  def text
    string
  end

  def size_inches
    return size_mm/25.4
  end
end