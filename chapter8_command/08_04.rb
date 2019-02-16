# システムにソフトウェアをセットアップするためのインストールプログラムを作る
# インストーラがインストール前後に行った履歴を残すCommandパターン
# もとに戻す機能を実装

require 'fileutils'

# 基底コマンドクラス
class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end

  def execute
  end
end

# ファイルを作成して文字列を書き出すコマンド
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, "w")
    f.write(@contents)
    f.close
  end

  def unexecute
    File.delete(@path)
  end
end

# ファイルを削除するためのコマンド
class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
    end
    f = File.delete(@path)
  end

  def unexecute
    if @contents
      f = File.open(@path, "w")
      f.write(@contents)
      f.close
    end
  end
end

# ファイルをコピーするコマンド
class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    if File.exists?(@target)
      @contents = File.read(@target)
    end
    FileUtils.copy(@source, @target)
  end

  def unexecute
    if @contents
      f = File.open(@target, "w")
      f.write(@contents)
      f.close
    else
      f = File.delete(@target)
    end
  end
end

# コマンドのように動作し、複数の子コマンドを持つ、コンポジットコマンドクラス
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each {|cmd| cmd.execute}
  end

  def unexecute
    @commands.reverse.each{|cmd| cmd.unexecute}
  end
  def description
    description = ''
    @commands.each {|cmd| description += cmd.description + "\n"}
    description
  end
end

cmds = CompositeCommand.new

cmds.add_command(CreateFile.new('file1.txt', "hello world\n"))
cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add_command(DeleteFile.new('file1.txt'))

cmds.execute
cmds.unexecute
