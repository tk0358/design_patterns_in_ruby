# ファイルを暗号化する既存クラス（ruby2.0以降の'getc'仕様変更により自分で変えた）
class Encypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    while not reader.eof?
      clear_char = reader.getc
      encrypted_num = clear_char.ord ^ @key[key_index].ord
      encrypted_char = encrypted_num.chr
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end

reader = File.open('message.txt')
writer = File.open('message.encrypted', 'w')
encrypter = Encypter.new('my secret key')
encrypter.encrypt(reader, writer)
reader.close
writer.close

reader = File.open('message.encrypted')
writer = File.open('message.decrypted', 'w')

encrypter.encrypt(reader, writer)
reader.close
writer.close