# シングルトンではないバージョンのロギングクラス
class SimpleLogger
  attr_accessor :level

  ERROR = 1
  WARNING = 2
  INFO = 3

  def initialize
    @log = File.open("log.txt", "w")
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
end

logger = SimpleLogger.new
logger.level = SimpleLogger::INFO

logger.info('１番目の処理を実行')
# 最初の処理を実行...
logger.info('２番目の処理を実行')
# 次の処理を実行...