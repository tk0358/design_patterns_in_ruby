class ClassBasedLogger
  ERROR = 1
  WARNING = 2
  INFO = 3
  @@log = File.open('log1210.txt', 'w')
  @@level = WARNING

  def self.error(msg)
    @@log.puts(msg)
    @@log.flush
  end

  def self.warning(msg)
    @@log.puts(msg) if @@level >= WARNING
    @@log.flush
  end

  def self.info(msg)
    @@log.puts(msg) if @@level >= INFO
    @@log.flush
  end

  def self.level=(new_level)
    @@level = new_level
  end

  def self.level
    @@level
  end
end

ClassBasedLogger.level = ClassBasedLogger::INFO

ClassBasedLogger.info('コンピュータがチェスゲームに勝ちました。')
ClassBasedLogger.warning('ユニットAE-35の故障が予測されました。')
ClassBasedLogger.error('HAL-9000　機能停止、緊急動作を実行します！')