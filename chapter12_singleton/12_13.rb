require 'singleton'

class DatabaseConnectionManager
  include Singleton

  def get_connection
    # データベースコネクションを返す
  end
end

class PreferenceManager
  def initialize
    @reader = PrefReader.new
    @writer = PrefWriter.new
    @preferences = { :display_splash=>false, :background_color=>:blue }
  end

  def save_preferences
    preferences = {}
    # プリファレンス情報はこの中に
    @writer.write(@preferences)
  end

  def get_preferences
    @preferences = @reader.read
  end
end

class PrefWriter
  def write(preferences)
    connection = DatabaseConnectionManager.instance.get_connection
    # プリファレンス情報を書き出す
  end
end

class PrefReader
  def read
    connection = DatabaseConnectionManager.instance.get_connection
    # プリファレンス情報を読みだしてそれを返す...
  end
end