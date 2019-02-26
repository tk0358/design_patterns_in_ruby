# method_missingの技術を使って、仮想プロキシーを作成

class VirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(name, *args)
    s = subject
    s.send( name, *args ) 
  end

  def subject
    @subject = @creation_block.call unless @subject
    @subject
  end
end

array = VirtualProxy.new { Array.new }
array << 'hello'
array << 'out'
array << 'there'

p array