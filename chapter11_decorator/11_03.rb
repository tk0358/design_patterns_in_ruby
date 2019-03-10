class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print "\n"
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

require 'forwardable'

class WriterDecorator
  extend Forwardable
  
  def_delegators :@real_writer, :write_line, :rewind, :pos, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

writer = NumberingWriter.new(SimpleWriter.new('fina1103_l.txt'))
writer.write_line("Hello out there11_03")
writer.write_line("This is Ruru")

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writer)
    @real_writer = real_writer
    @check_sum = 0
  end

  def write_line(line)
    line.each_byte {|byte| @check_sum + (@check_sum + byte) % 256 }
    @check_sum += "\n".sum % 256    # 本書では "\n"[0] % 256
    @real_writer.write_line(line)
  end
end

class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.now}: #{line}")
  end
end

writer = CheckSummingWriter.new(TimeStampingWriter.new(
           NumberingWriter.new(SimpleWriter.new('final1103_2.txt'))))
writer.write_line('Hello out there')
