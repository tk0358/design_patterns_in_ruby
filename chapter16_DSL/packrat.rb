require_relative './finder'

def backup(dir, find_expression=All.new)
  puts "Backup called, source dir=#{dir} find expr=#{find_expression}"
end

def to(backup_directory)
  puts "To called, backup dir=#{backup_directory}"
end

def interval(nimutes)
  puts "Interval called, interval = #{minutes} minutes"
end

eval(File.read('backup.pr'))
