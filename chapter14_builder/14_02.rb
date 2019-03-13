class Computer
  attr_accessor :display
  attr_accessor :motherboard
  attr_reader :drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @display = display
    @motherboard = motherboard
    @drives = drives
  end
end

class CPU
  # CPU共通のコード...
end

class BasicCPU < CPU
  # あまり高速でないCPUに関するたくさんのコード
end

class TurboCPU < CPU
  # 超高速CPUに関するたくさんのコード
end

class Motherboard
  attr_accessor :cpu
  attr_accessor :memory_size
  def initialize(cpr=BasicCPU.new, memory_size=1000)
    @cpu = cpu
    @memory_size = memory_size
  end
end

class Drive
  attr_reader :type # :hard_disk か :cd か :DVD
  attr_reader :size # MBで
  attr_reader :writable # ドライブが書き込み可能ならばtrue

  initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

class ComputerBuilder
  attr_reader :computer

  def initialize
    @computer = Computer.new  
  end

  def turbo(has_turbo_cup=true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def display=(display)
    @computer.display=display
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

  def add_cd(writer=false)
    @computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    @computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end
end

builder = ComputerBuilder.new
builder.turbo
builder.add_cd(true)
builder.add_dvd
builder.add_hard_disk(100000)

computer = builder.computer