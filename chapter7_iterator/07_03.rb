# ソートされた配列２つを、１つのソートされた配列にマージしようとする場合には、
# 外部イテレータを使う方がとても簡単。
#
# ２つの入力配列それぞれにイテレータを作成し、どちらかのイテレータから最も小さい値を出力配列へ
# 繰り返し渡すことによって配列をマージできる

class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

def merge(array1, array2)
  merged = []

  iterator1 = ArrayIterator.new(array1)
  iterator2 = ArrayIterator.new(array2)

  while( iterator1.has_next? and iterator2.has_next? )
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # array1から残りを取り出す
  while( iterator1.has_next?)
    merged << iterato1.next_item
  end

  # arry2から残りを取り出す
  while( iterator2.has_next?)
    merged << iterator2.next_item
  end

  merged
end

ary1 = [2, 3, 5, 9]
ary2 = [4, 5, 6, 8, 10, 12]
p merge(ary1, ary2)
