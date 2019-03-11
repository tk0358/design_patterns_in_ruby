class SimpleLogger
  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3

  def initialize
    @log = File.open("log1207.txt", "w")
    @level = WARNING
  end

  def error(msg)
    @log.puts(msg)
    @log.flush
  end

  def warning(msg)
    @log.puts(msg) if @level >= WARNING
    @log.flush
  end

  def info(msg)
    @log.puts(msg) if @level >= INFO
    @log.flush
  end

  @@instance = SimpleLogger.new

  def self.instance
    return @@instance
  end
end

logger1 = SimpleLogger.instance # ロガーのオブジェクトが返る
logger2 = SimpleLogger.instance # まったく同じオブジェクトが返る
p logger1
p logger2

SimpleLogger.instance.info('コンピュータがチェスゲームに勝ちました。')
SimpleLogger.instance.warning('ユニットAE-35の故障が予測されました。')
SimpleLogger.instance.error('HAL-9000　機能停止、緊急動作を実行します！')

another_logger = SimpleLogger.new # SimpleLoggerの別のインスタンスを作ることができてしまう
p another_logger