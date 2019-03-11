# クラス定義の内側においてself変数は定義中のクラスを表す
class SomeClass
  puts("クラス定義の内側で、selfは#{self}")
end