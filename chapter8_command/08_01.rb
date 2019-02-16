class SlickButton
  attr_accessor :command

  def initialize(command)
    @command = command
  end

  # ボタンの描画と管理のためのコード
  # コードを省略
  
  def on_button_push
    @command.execute if @command
  end
end

class SaveCommand
  def execute
    # 現在の文書を保存
  end
end

save_button = SlickButton.new( SaveCommand.new )