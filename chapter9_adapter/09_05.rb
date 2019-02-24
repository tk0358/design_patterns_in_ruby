# 元のクラスをロードする

require 'british_text_object'

# 元のクラスにメソッドを追加する

class BritishTextObject
  def color
    return colour
  end

  def text
    return string
  end

  def size_inches
    return size_mm / 25.4
  end
end