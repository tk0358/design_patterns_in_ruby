class Engine
  def start_engine
    # エンジンを始動する...
  end

  def stop_engine
    # エンジンを停止する...
  end
end

class Car
  extend Forwardable

  def_delegators :@engine, :start_engine, :stop_engine

  def initialize
    @engine = Engine.new
  end
end