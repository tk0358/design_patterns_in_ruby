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