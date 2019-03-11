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
    @writer.write(DatabaseConnectionManager.instance, @preferences)
  end

  def get_preferences
    @preferences = @reader.read(DatabaseConnectionManager.instance)
  end
end