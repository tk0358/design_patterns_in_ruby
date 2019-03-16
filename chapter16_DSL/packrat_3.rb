require_relative './finder'
require_relative './backup_2'
require_relative './data_source'

class PackRat
  include Singleton

  def initialize
    @backups = []  
  end

  def register_backup(backup)
    @backups << backup
  end

  def run
    threads = []
    @backups.each do |backup|
      threads << Thread.new {backup.run}
    end
    threads.each {|t| t.join}
  end
end

eval(File.read('backup_2.pr'))
PackRat.instance.run