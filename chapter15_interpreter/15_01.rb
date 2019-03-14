require 'find'

class Expression
  # 一般的な式のコードはここに追加される...
end

# すべてのファイルを検索
class All < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p
    end
    results
  end
end

# 名前でファイルを検索
class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(@pattern, name)
    end
  end
end

# test_dirディレクトリ内のファイルをすべて検索
expr_all = All.new
files = expr_all.evaluate('test_dir')
p files

# test_dirディレクトリ内のMP３ファイルだけを検索
expr_mp3 = FileName.new('*.mp3')
mp3s = expr_mp3.evaluate('test_dir')
p mp3s

# 指定されたサイズより大きいファイルを検索
class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if File.size(p) > @size
    end
    results
  end
end

# 書き込み可能なファイルを検索
class Writable < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if File.writable?(p)
    end
    results
  end
end

# 非終端Not
class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

# 書き込み可能でないファイルを検索
expr_not_writable = Not.new( Writable.new )
readonly_files = expr_not_writable.evaluate('test_dir')

# 1KBより小さいファイルを検索
small_expr = Not.new( Bigger.new(1024) )
small_files = small_expr.evaluate('test_dir')

# MP3以外のファイルを検索
not_mp3_expr = Not.new( FileName.new('*.mp3') )
not_mp3s = not_mp3_expr.evaluate('test_dir')

# 非終端Or
class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

# MP3ファイルまたは１KBより大きいファイルを検索
big_or_mp3_expr = Or.new( Bigger.new(1024), FileName.new('*.mp3') )
big_or_mpp3s = big_or_mp3_expr.evaluate('test_dir')

# 非終端And
class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

# 書き込み可能でない大きなMP3ファイルを検索する場合
complex_expression = And.new(
                       And.new(Bigger.new(1024), FileName.new('*.mp3')),
                       Not.new(Writable.new))

# 別のコンテキストで使う
complex_expression.evaluate('test_dir')
complex_expression.evaluate('/tmp')

class Parser
  def initialize(text)
    @tokens = text.scan(/\(|\)|[\w\.\*]+/)
  end

  def next_token
    @tokens.shift
  end

  def expression
    token = next_token

    if token = nil
      return nil

    elsif token == '('
      result = expression
      raise 'Expected)' unless next_token == ')'
      result

    elsif token == 'all'
      return All.new

    elsif token == 'writable'
      return Writable.new

    elsif token == 'bigger'
      return Bigger.new(next_token.to_i)

    elsif token == 'filename'
      return FileName.new(next_token)

    elsif token == 'not'
      return Not.new(expression)

    elsif token == 'and'
      return And.new(expression, expression)

    elsif token == 'or'
      return Or.new(expression, expression)

    else
      raise "Unexpected token: #{token}"
    end
  end
end

parser = Parser.new "and (and(bigger 1024)(filename *.mp3)) writable"
ast = parser.expression