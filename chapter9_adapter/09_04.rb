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

# Adapterパターンを使って、BritishTextObjectのインターフェースの問題を解決する
class BritishTextObjectAdapter < TextObject
  def initialize(bto)
    @bto = bto
  end

  def text
    return @bto.string
  end

  def size_inches
    return @bto.size_mm / 25.4
  end

  def color
    return @bto.colour
  end
end