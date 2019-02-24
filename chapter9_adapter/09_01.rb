# ファイルを暗号化する既存クラス（書籍のまま）
# ruby1.8時代のgetcの仕様を使っているので、ruby2.0以降ではエラー
# 動くバージョンは09_02.rbへ
class Encypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    while not reader.eof?
      clear_char = reader.getc
      encrypted_char = clear_char^ @key[key_index]
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end

reader = File.open('message.txt')
writer = File.open('message.encrypted', 'w')
encrypter = Encypter.new('my secret key')
encrypter.encrypt(reader, writer)

reader = File.open('message.encrypted')
writer = File.open('message.decrypted', 'w')
encrypter = Encypter.new('my secret key')
encrypter.encrypt(reader, writer)